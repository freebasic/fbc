/* unix base target-specific header */

#include <fcntl.h>
#include <unistd.h>
#include <termios.h>
#include <dirent.h>
#include <dlfcn.h>
#include <pthread.h>

#include <termcap.h>

#include <sys/io.h>
#include <sys/ioctl.h>
#include <sys/time.h>
#include <sys/stat.h>
#ifdef HOST_LINUX
#include <sys/mman.h>
#endif
#include <sys/wait.h>
#include <sys/select.h>

#define FBCALL

/* newline for console/file I/O */
#define FB_NEWLINE "\n"
#define FB_NEWLINE_WSTR _LC("\n")

/* newline for printer I/O */
#define FB_BINARY_NEWLINE "\r\n"
#define FB_BINARY_NEWLINE_WSTR _LC("\r\n")

#define FB_LL_FMTMOD "ll"

typedef struct _FB_DIRCTX
{
	int in_use;
	int attrib;
	DIR *dir;
	char filespec[MAX_PATH];
	char dirname[MAX_PATH];
} FB_DIRCTX;

#ifdef ENABLE_MT
	extern pthread_mutex_t __fb_global_mutex;
	extern pthread_mutex_t __fb_string_mutex;
#	define FB_LOCK()             pthread_mutex_lock(&__fb_global_mutex)
#	define FB_UNLOCK()           pthread_mutex_unlock(&__fb_global_mutex)
#	define FB_STRLOCK()          pthread_mutex_lock(&__fb_string_mutex)
#	define FB_STRUNLOCK()        pthread_mutex_unlock(&__fb_string_mutex)
#	define FB_TLSENTRY           pthread_key_t
#	define FB_TLSALLOC(key)      pthread_key_create( &(key), NULL )
#	define FB_TLSFREE(key)       pthread_key_delete( (key) )
#	define FB_TLSSET(key,value)  pthread_setspecific((key), (const void *)(value))
#	define FB_TLSGET(key)        pthread_getspecific((key))
#else
#	define FB_LOCK()
#	define FB_UNLOCK()
#	define FB_STRLOCK()
#	define FB_STRUNLOCK()
#	define FB_TLSENTRY           uintptr_t
#	define FB_TLSALLOC(key)      key = NULL
#	define FB_TLSFREE(key)       key = NULL
#	define FB_TLSSET(key,value)  key = (FB_TLSENTRY)value
#	define FB_TLSGET(key)        key
#endif

#define FB_THREADID pthread_t
#define FB_DYLIB void*

typedef struct {
	pthread_mutex_t id;
} FBMUTEX;

/* Forward-declared FBCOND type */
struct _FBCOND;
typedef struct _FBCOND FBCOND;

typedef off_t fb_off_t;

#define INIT_CONSOLE		1
#define INIT_X11			2

#define TERM_GENERIC		0
#define TERM_XTERM			1
#define TERM_ETERM			2

#define BG_LOCK()			pthread_mutex_lock(&__fb_con.bg_mutex);
#define BG_UNLOCK()			pthread_mutex_unlock(&__fb_con.bg_mutex);

#define SEQ_LOCATE			0			/* "cm" - move cursor */
#define SEQ_HOME			1			/* "ho" - home cursor */
#define SEQ_SCROLL_REGION	2			/* "cs" - set scrolling region */
#define SEQ_CLS				3			/* "cl" - clear whole screen */
#define SEQ_CLEOL			4			/* "ce" - clear until end of line */
#define SEQ_WINDOW_SIZE		5			/* "WS" - set terminal window size */
#define SEQ_BEEP			6			/* "bl" - beep */
#define SEQ_FG_COLOR		7			/* "AF" - set foreground color */
#define SEQ_BG_COLOR		8			/* "AB" - set background color */
#define SEQ_RESET_COLOR		9			/* "me" - turn off all attributes */
#define SEQ_BRIGHT_COLOR	10			/* "md" - turn on bold (bright) attribute */
#define SEQ_SCROLL			11			/* "SF" - scroll forward */
#define SEQ_SHOW_CURSOR		12			/* "ve" - make cursor visible */
#define SEQ_HIDE_CURSOR		13			/* "vi" - make cursor invisible */
#define SEQ_DEL_CHAR		14			/* "dc" - delete character at cursor position */
#define SEQ_INIT_KEYPAD		15			/* "ks" - enable keypad keys */
#define SEQ_EXIT_KEYPAD		16			/* "ke" - disable keypad keys */
#define SEQ_MAX				17
#define SEQ_EXTRA			100

#ifdef HOST_LINUX
#define SEQ_INIT_CHARSET	100			/* xxxx - inits PC 437 characters set */
#define SEQ_EXIT_CHARSET	101			/* xxxx - exits PC 437 characters set */
#define SEQ_QUERY_CURSOR	102			/* xxxx - query cursor position (not in termcap) */
#define SEQ_QUERY_WINDOW	103			/* xxxx - query terminal window size (not in termcap) */
#define SEQ_INIT_XMOUSE		104			/* xxxx - enable X11 mouse */
#define SEQ_EXIT_XMOUSE		105			/* xxxx - disable X11 mouse */
#define SEQ_EXIT_GFX_MODE	106			/* xxxx - cleanup after console gfx mode */
#endif

#define SEQ_SET_COLOR_EX	107			/* xxxx - extended set color */

typedef struct FBCONSOLE
{
	int inited;
	int term_type;
	int h_out, h_in;
	FILE *f_out, *f_in;
	struct termios old_term_out, old_term_in;
	int in_flags, old_in_flags;
	int fg_color, bg_color;
	int cur_x, cur_y;
	int w, h;
	unsigned char *char_buffer, *attr_buffer;
	pthread_t bg_thread;
	pthread_mutex_t bg_mutex;
	int has_perm;
	char *seq[SEQ_MAX];
	int (*keyboard_getch)(void);
	int (*keyboard_init)(void);
	void (*keyboard_exit)(void);
	void (*keyboard_handler)(void);
	int (*mouse_init)(void);
	void (*mouse_exit)(void);
	void (*mouse_handler)(void);
	void (*mouse_update)(int cb, int cx, int cy);
	void (*gfx_exit)(void);
} FBCONSOLE;

extern FBCONSOLE __fb_con;

int fb_hTermOut( int code, int param1, int param2);
int fb_hGetCh(int remove);
int fb_hXTermInitFocus(void);
void fb_hXTermExitFocus(void);
int fb_hXTermHasFocus(void);
int fb_hConsoleGfxMode(void (*gfx_exit)(void), void (*save)(void), void (*restore)(void), void (*key_handler)(int));
int fb_hInitConsole(void);
void fb_hExitConsole(void);
