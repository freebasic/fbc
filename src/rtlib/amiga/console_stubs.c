/* AmigaOS console implementation via ANSI escape sequences + dos.library */
#include "../fb.h"
#include <string.h>
#include <stdio.h>

#if defined(HOST_AMIGAOS)
#include <proto/dos.h>
extern struct DosLibrary *DOSBase;

static long dos_Input(void) { return (long)Input(); }
static long dos_Output(void) { return (long)Output(); }
static long dos_Read(long fh, void *buf, long len) { return Read((BPTR)fh, buf, len); }
static void dos_Write(long fh, const void *buf, long len) { Write((BPTR)fh, (APTR)buf, len); }
/* WaitForChar: timeout in microseconds (0 = poll, -1 = wait forever) */
static long dos_WaitForChar(long fh, long timeout) { return WaitForChar((BPTR)fh, timeout); }
static void dos_Delay(long ticks) { Delay(ticks); }

static void con_write(const char *s) {
    dos_Write(dos_Output(), s, strlen(s));
}



#else
/* AROS/MorphOS - use POSIX stdio */
#include <unistd.h>
#include <stdlib.h>
#include <sys/select.h>
#define con_write(s) fputs(s, stdout)
#define dos_Input() STDIN_FILENO
#define dos_Output() STDOUT_FILENO
#define dos_Read(fh, buf, len) read(STDIN_FILENO, buf, len)
#define dos_Write(fh, buf, len) write(STDOUT_FILENO, buf, len)
static int dos_WaitForChar_posix(int fd, long timeout_us) {
    struct timeval tv;
    fd_set fds;
    tv.tv_sec = timeout_us / 1000000;
    tv.tv_usec = timeout_us % 1000000;
    FD_ZERO(&fds);
    FD_SET(fd, &fds);
    return select(fd + 1, &fds, NULL, NULL, timeout_us < 0 ? NULL : &tv) > 0;
}
#define dos_WaitForChar(fh, t) dos_WaitForChar_posix(STDIN_FILENO, t)
#define dos_Delay(t) usleep((t) * 20000)
#endif

/* --- Console state --- */
static int con_x = 1, con_y = 1;
static int con_fg = 7, con_bg = 0;
static int con_w = 80, con_h = 25;

/* --- Size --- */
FBCALL void fb_ConsoleGetSize(int *cols, int *rows) {
    if (cols) *cols = con_w;
    if (rows) *rows = con_h;
}

/* --- Position --- */
FBCALL void fb_ConsoleGetXY(int *col, int *row) {
    if (col) *col = con_x;
    if (row) *row = con_y;
}

int fb_ConsoleGetX(void) { return con_x; }
int fb_ConsoleGetY(void) { return con_y; }

int fb_ConsoleLocate(int row, int col, int cursor) {
    /* row/col of 0 means "keep current position" */
    int r = (row > 0) ? row : con_y;
    int cl = (col > 0) ? col : con_x;
    char buf[32];
    snprintf(buf, sizeof(buf), "\033[%d;%dH", r, cl);
    con_write(buf);
    con_y = r; con_x = cl;
    return 0;
}

/* --- Color (ANSI) --- */
unsigned int fb_ConsoleColor(unsigned int fc, unsigned int bc, int flags) {
    unsigned int old = con_fg | (con_bg << 4);
    /* Map FB colors (0-15) to ANSI (30-37 + bright) */
    static const int ansi_fg[] = {30,34,32,36,31,35,33,37,90,94,92,96,91,95,93,97};
    static const int ansi_bg[] = {40,44,42,46,41,45,43,47,100,104,102,106,101,105,103,107};
    if (fc <= 15) { con_fg = fc; char buf[12]; snprintf(buf, sizeof(buf), "\033[%dm", ansi_fg[fc]); con_write(buf); }
    if (bc <= 15) { con_bg = bc; char buf[12]; snprintf(buf, sizeof(buf), "\033[%dm", ansi_bg[bc]); con_write(buf); }
    return old;
}

unsigned int fb_ConsoleGetColorAtt(void) { return con_fg | (con_bg << 4); }

/* --- Clear --- */
void fb_ConsoleClear(int mode) {
    switch (mode) {
        case 0: /* Clear screen and home cursor */
            con_write("\033[2J\033[H");
            con_x = 1; con_y = 1;
            break;
        case 1: /* No-op (clear active page - not applicable) */
            break;
        case 2: /* Clear active view */
            con_write("\033[2J\033[H");
            con_x = 1; con_y = 1;
            break;
    }
}

/* --- Scroll --- */
void fb_ConsoleScroll(int nrows) {
    int i;
    if (nrows > 0) { for (i = 0; i < nrows; i++) con_write("\033[S"); }
    else if (nrows < 0) { for (i = 0; i < -nrows; i++) con_write("\033[T"); }
}

/* --- Width --- */
int fb_ConsoleWidth(int cols, int rows) {
    if (cols > 0) con_w = cols;
    if (rows > 0) con_h = rows;
    return 0;
}

/* --- View --- */
FBCALL int fb_ConsoleView(int toprow, int botrow) { return 0; }
int fb_ConsoleViewEx(int toprow, int botrow, int set_cursor) { return 0; }
void fb_ConsoleGetView(int *toprow, int *botrow) { if (toprow) *toprow = 1; if (botrow) *botrow = con_h; }
int fb_ConsoleGetMaxRow(void) { return con_h; }
void fb_ConsoleViewUpdate(void) { }
int fb_ConsoleGetTopRow(void) { return 1; }
int fb_ConsoleGetBotRow(void) { return con_h; }
void fb_ConsoleSetTopBotRows(int top, int bot) { }

/* --- Keyboard Input --- */
int fb_ConsoleGetkey(void) {
    long in = dos_Input();
    if (!in) return 0;
    char c;
    if (dos_Read(in, &c, 1) != 1) return 0;
    if (c != 27) return (unsigned char)c;
    /* Escape sequence: parse CSI */
    if (!dos_WaitForChar(in, 20000)) return 27;
    if (dos_Read(in, &c, 1) != 1) return 27;
    if (c != '[') return 27;
    if (!dos_WaitForChar(in, 20000)) return 27;
    if (dos_Read(in, &c, 1) != 1) return 27;
    /* Map ANSI arrow/function keys to FB extended codes (256 + scancode) */
    switch (c) {
        case 'A': return 0x4800; /* Up */
        case 'B': return 0x5000; /* Down */
        case 'C': return 0x4D00; /* Right */
        case 'D': return 0x4B00; /* Left */
        case 'H': return 0x4700; /* Home */
        case 'F': return 0x4F00; /* End */
        default:  return 27;
    }
}

FBSTRING *fb_ConsoleInkey(void) {
    long in = dos_Input();
    if (!in || !dos_WaitForChar(in, 0))
        return fb_StrAllocTempDescZEx(NULL, 0);
    char c;
    if (dos_Read(in, &c, 1) != 1)
        return fb_StrAllocTempDescZEx(NULL, 0);
    if (c != 27)
        return fb_StrAllocTempDescZEx(&c, 1);
    /* Parse escape sequence */
    if (!dos_WaitForChar(in, 20000))
        return fb_StrAllocTempDescZEx(&c, 1); /* Just ESC */
    char c2;
    if (dos_Read(in, &c2, 1) != 1)
        return fb_StrAllocTempDescZEx(&c, 1);
    if (c2 != '[') {
        char ext[2] = { (char)255, c2 };
        return fb_StrAllocTempDescZEx(ext, 2);
    }
    if (!dos_WaitForChar(in, 20000))
        return fb_StrAllocTempDescZEx(NULL, 0);
    char c3;
    if (dos_Read(in, &c3, 1) != 1)
        return fb_StrAllocTempDescZEx(NULL, 0);
    /* Map ANSI CSI to FB extended key (CHR$(255) + scancode) */
    char ext[2] = { (char)255, 0 };
    switch (c3) {
        case 'A': ext[1] = 0x48; break; /* Up */
        case 'B': ext[1] = 0x50; break; /* Down */
        case 'C': ext[1] = 0x4D; break; /* Right */
        case 'D': ext[1] = 0x4B; break; /* Left */
        case 'H': ext[1] = 0x47; break; /* Home */
        case 'F': ext[1] = 0x4F; break; /* End */
        default:  return fb_StrAllocTempDescZEx(NULL, 0);
    }
    return fb_StrAllocTempDescZEx(ext, 2);
}

int fb_ConsoleKeyHit(void) {
    long in = dos_Input();
    return (in && dos_WaitForChar(in, 0)) ? FB_TRUE : FB_FALSE;
}

/* --- ReadStr (for INPUT/LINE INPUT from console) --- */
char *fb_ConsoleReadStr(char *buffer, ssize_t len) {
    if (!buffer || len <= 0) return buffer;
    if (len == 1) { buffer[0] = '\0'; return buffer; }
    long in = dos_Input();
    if (!in) { buffer[0] = '\0'; return buffer; }
    ssize_t i = 0;
    while (i < len - 1) {
        char c;
        long r = dos_Read(in, &c, 1);
        if (r <= 0 || c == '\n') break;
        if (c == '\r') continue;
        if (c == 8 || c == 127) { /* Backspace/Delete */
            if (i > 0) { i--; con_write("\010 \010"); }
            continue;
        }
        buffer[i++] = c;
        dos_Write(dos_Output(), &c, 1); /* Echo single char */
    }
    buffer[i] = '\0';
    con_write("\n");
    return buffer;
}

/* --- Sleep --- */
void fb_ConsoleSleep(int msecs) {
    if (msecs < 0) {
        /* Sleep until keypress */
        long in = dos_Input();
        if (in) { char c; dos_Read(in, &c, 1); }
    } else if (msecs == 0) {
        /* Yield CPU timeslice */
        dos_Delay(1);
    } else {
        long ticks = msecs / 20;
        if (ticks < 1) ticks = 1;
        dos_Delay(ticks);
    }
}

/* --- Misc --- */
FBCALL unsigned int fb_ConsoleReadXY(int col, int row, int colorflag) { return 32; }
int fb_ConsoleIsRedirected(int is_input) {
#if defined(HOST_AMIGAOS)
    long fh = is_input ? dos_Input() : dos_Output();
    if (!fh) return 1;
    /* dos.library IsInteractive() */
    return IsInteractive((BPTR)fh) ? 0 : 1;
#else
    int fd = is_input ? STDIN_FILENO : STDOUT_FILENO;
    return isatty(fd) ? 0 : 1;
#endif
}
int fb_ConsolePageCopy(int src, int dst) { return 0; }
int fb_ConsolePageSet(int active, int visible) { return 0; }
