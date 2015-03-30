/* libfb initialization for Unix */

/* for getpgid() */
#define _GNU_SOURCE 1

#include "../fb.h"
#include "fb_private_console.h"
#include "../fb_private_thread.h"
#include <signal.h>
#include <termcap.h>
#ifdef HOST_LINUX
#include <sys/io.h>
#endif
#include <sys/ioctl.h>
#include <fcntl.h>

FBCONSOLE __fb_con;

typedef void (*SIGHANDLER)(int);
static SIGHANDLER old_sighandler[NSIG];
static volatile sig_atomic_t __fb_console_resized;
static const char *seq[] = { "cm", "ho", "cs", "cl", "ce", "WS", "bl", "AF", "AB",
							 "me", "md", "SF", "ve", "vi", "dc", "ks", "ke" };

static pthread_t __fb_bg_thread;
static int bgthread_inited = FALSE;
static pthread_mutex_t __fb_bg_mutex;
FBCALL void fb_BgLock   ( void ) { pthread_mutex_lock  ( &__fb_bg_mutex     ); }
FBCALL void fb_BgUnlock ( void ) { pthread_mutex_unlock( &__fb_bg_mutex     ); }

#ifdef ENABLE_MT
extern int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int kind);

static pthread_mutex_t __fb_global_mutex;
static pthread_mutex_t __fb_string_mutex;
static pthread_mutex_t __fb_graphics_mutex;
FBCALL void fb_Lock     ( void ) { pthread_mutex_lock  ( &__fb_global_mutex ); }
FBCALL void fb_Unlock   ( void ) { pthread_mutex_unlock( &__fb_global_mutex ); }
FBCALL void fb_StrLock  ( void ) { pthread_mutex_lock  ( &__fb_string_mutex ); }
FBCALL void fb_StrUnlock( void ) { pthread_mutex_unlock( &__fb_string_mutex ); }
FBCALL void fb_GraphicsLock  ( void ) { pthread_mutex_lock  ( &__fb_graphics_mutex ); }
FBCALL void fb_GraphicsUnlock( void ) { pthread_mutex_unlock( &__fb_graphics_mutex ); }
#endif

static void *bg_thread(void *arg)
{
	while (__fb_con.inited) {

		BG_LOCK();
		if (__fb_con.keyboard_handler)
			__fb_con.keyboard_handler();
		if (__fb_con.mouse_handler)
			__fb_con.mouse_handler();
		BG_UNLOCK();

		usleep(30000);
	}
	return NULL;
}

void fb_hStartBgThread( void )
{
	if( bgthread_inited == FALSE ) {
		pthread_create( &__fb_bg_thread, NULL, bg_thread, NULL );
		bgthread_inited = TRUE;
	}
}

static int default_getch(void)
{
	return fgetc(__fb_con.f_in);
}

static void signal_handler(int sig)
{
	signal(sig, old_sighandler[sig]);
	fb_hEnd(1);
	raise(sig);
}

#ifdef HOST_LINUX
/* Query window size or cursor position from the terminal by sending the
   respective escape sequence to stdout and reading the answer (report) from
   stdin.
   That's assuming that the terminal actually supports the escape sequence and
   sends a response. If it does not, we'll hang forever (or at least until the
   read from stdin returns EOF).
   Used with SEQ_QUERY_WINDOW and SEQ_QUERY_CURSOR only (but could easily be
   extended to support more). */
int fb_hTermQuery( int code, int *val1, int *val2 )
{
	if( fb_hTermOut( code, 0, 0 ) == FALSE )
		return FALSE;

	int filled;
	do {
		/* The terminal should have sent its reply through stdin. However, it's
		   possible that there's other data pending in stdin, e.g. if the user
		   happened to press a key at the right time. */

		/* Read until an '\e[' (ESC char followed by '[') is reached,
		   it should be the begin of the terminal's answer string) */
		int c;
		do {
			do {
				c = getchar( );
				if( c == EOF ) return FALSE;
				if( c == '\e' ) break;

				/* Add skipped char to Inkey() buffer so it's not lost */
				fb_hAddCh( c );
			} while (1);

			c = getchar( );
			if( c == '[' ) break;

			/* ditto */
			fb_hAddCh( c );
		} while (1);

		const char *format;
		if( code == SEQ_QUERY_WINDOW )
			format = "8;%d;%dt";
		else /* SEQ_QUERY_CURSOR */
			format = "%d;%dR";

		filled = scanf( format, val1, val2 );
	} while (filled != 2);

	return TRUE;
}
#endif

/**
 * Update our cursor position with information from the terminal, if possible,
 * to make it more accurate. (It's possible that the cursor moved outside of
 * our control; e.g. if the FB program did a printf() instead of using FB's
 * PRINT)
 */
void fb_hRecheckCursorPos( void )
{
#ifdef HOST_LINUX
	int x = 0;
	int y = 0;
	if( fb_hTermQuery( SEQ_QUERY_CURSOR, &y, &x ) ) {
		__fb_con.cur_x = x;
		__fb_con.cur_y = y;
	}
#endif
}

/**
 * Check whether the SIGWINCH handler has been called, and if so, re-query
 * the terminal width/height.
 *  - Assuming BG_LOCK() is acquired, because this can be called from
 *    linux/io_mouse.c:mouse_handler() from the background thread
 *  - Assuming __fb_con.inited
 *
 *  The "requery_cursorpos" parameter allows callers to disable the cursor
 *  position update we'd normally do too in this case. This is useful if the
 *  caller wants to do it manually, regardless of whether SIGWINCH happened,
 *  while at the same time avoiding duplicate queries.
 */
void fb_hRecheckConsoleSize( int requery_cursorpos )
{
	if( __fb_console_resized == FALSE )
		return;

	/* __fb_console_resized may be set to TRUE again here if a SIGWINCH
	   arrives while we're doing this check.

	   If it happens here before we're setting __fb_console_resized to FALSE
	   then it doesn't matter, because we're about to check the console size
	   anyways.

	   If it happens later (during/after the check below) then we'll miss
	   it this time; but at least the next fb_hRecheckConsoleSize() will
	   handle it. */

	__fb_console_resized = FALSE;

	/* Try to query the terminal size */
	/* Try TIOCGWINSZ */
	struct winsize win = { 0, 0, 0, 0 };
	ioctl( STDOUT_FILENO, TIOCGWINSZ, &win );
#ifdef HOST_LINUX
	if( win.ws_row == 0 || win.ws_col == 0 ) {
		/* Try an escape sequence */
		int r, c;
		if( fb_hTermQuery( SEQ_QUERY_WINDOW, &r, &c ) ) {
			win.ws_row = r;
			win.ws_col = c;
		}
	}
#endif

	/* Fallback to defaults if all above queries failed */
	/* Besides probably being correct, this also means we don't have to
	   handle the case of unknown terminal size all over the rtlib code.
	   For example, fb_ConReadLine() assumes that fb_GetSize() returns
	   non-zero rows/columns. */
	if( win.ws_row == 0 || win.ws_col == 0 ) {
		win.ws_row = 25;
		win.ws_col = 80;
	}

	unsigned char *char_buffer = calloc(1, win.ws_row * win.ws_col * 2);
	unsigned char *attr_buffer = char_buffer + (win.ws_row * win.ws_col);
	if (__fb_con.char_buffer) {
		int h = (__fb_con.h < win.ws_row) ? __fb_con.h : win.ws_row;
		int w = (__fb_con.w < win.ws_col) ? __fb_con.w : win.ws_col;
		int r;
		for (r = 0; r < h; r++) {
			memcpy(char_buffer + (r * win.ws_col), __fb_con.char_buffer + (r * __fb_con.w), w);
			memcpy(attr_buffer + (r * win.ws_col), __fb_con.attr_buffer + (r * __fb_con.w), w);
		}
		free(__fb_con.char_buffer);
	}
	__fb_con.char_buffer = char_buffer;
	__fb_con.attr_buffer = attr_buffer;
	__fb_con.h = win.ws_row;
	__fb_con.w = win.ws_col;

	/* Also update the cursor position if wanted */
	if (requery_cursorpos) {
		fb_hRecheckCursorPos( );
	}
}

static void sigwinch_handler(int sig)
{
	__fb_console_resized = TRUE;
	signal(SIGWINCH, sigwinch_handler);
}

int fb_hTermOut( int code, int param1, int param2 )
{
	/* Hard-coded VT100 terminal escape sequences corresponding to our SEQ_*
	   #defines with values >= 100. Apparently these codes are not available
	   through termcap/terminfo (tgetstr()), so we need to hard-code them.

	   These cannot safely be used for some (old) terminals which don't
	   support them, as the terminal won't recognize them, thus won't send
	   a response, leaving us hanging and waiting for a response. We don't
	   have a good way of preventing this issue though especially since we
	   can't rely on termcap/terminfo for this.

	   Thus, we provide the __fb_enable_vt100_escapes global variable, which
	   FB programs can set to TRUE or FALSE as needed at runtime. */
	const char *extra_seq[] = { "\e(U", "\e(B", "\e[6n", "\e[18t",
		"\e[?1000h\e[?1003h", "\e[?1003l\e[?1000l", "\e[H\e[J\e[0m" };

	char *str;

	if (!__fb_con.inited)
		return FALSE;

	if (code > SEQ_MAX) {

		/* Is use of the VT100 escape sequences disallowed? */
		if (!__fb_enable_vt100_escapes)
			return FALSE;

		switch (code) {
		case SEQ_SET_COLOR_EX:
			if( fprintf( stdout, "\e[%dm", param1 ) < 4 )
				return FALSE;
			break;
		default:
			if( fputs( extra_seq[code - SEQ_EXTRA], stdout ) == EOF )
				return FALSE;
			break;
		}
	} else {
		if (!__fb_con.seq[code])
			return FALSE;
		str = tgoto(__fb_con.seq[code], param1, param2);
		if (!str)
			return FALSE;
		tputs(str, 1, putchar);
	}

	/* Ensure the terminal gets to see the escape sequence */
	fflush( stdout );

	return TRUE;
}

int fb_hInitConsole( )
{
	struct termios term_out, term_in;

	if (!__fb_con.inited)
		return -1;

	/* Init terminal I/O */
	if( !isatty( STDOUT_FILENO ) || !isatty( STDIN_FILENO ) )
		return -1;
	__fb_con.f_in = fopen("/dev/tty", "r+b");
	if (!__fb_con.f_in)
		return -1;
	__fb_con.h_in = fileno(__fb_con.f_in);
	
	/* Cannot control console if process was started in background */
	if( tcgetpgrp( STDOUT_FILENO ) != getpgid( 0 ) )
		return -1;

	/* Output setup */
	if( tcgetattr( STDOUT_FILENO, &__fb_con.old_term_out ) )
		return -1;
	memcpy(&term_out, &__fb_con.old_term_out, sizeof(term_out));
	term_out.c_oflag |= OPOST;
	if( tcsetattr( STDOUT_FILENO, TCSANOW, &term_out ) )
		return -1;

	/* Input setup */
	if (tcgetattr(__fb_con.h_in, &__fb_con.old_term_in))
		return -1;
	memcpy(&term_in, &__fb_con.old_term_in, sizeof(term_in));
	/* Send SIGINT on control-C */
	term_in.c_iflag |= BRKINT;
	/* Disable Xon/off and input BREAK condition ignoring */
	term_in.c_iflag &= ~(IXOFF | IXON | IGNBRK);
	/* Character oriented, no echo */
	term_in.c_lflag &= ~(ICANON | ECHO);
	/* No timeout, just don't block */
	term_in.c_cc[VMIN] = 1;
	term_in.c_cc[VTIME] = 0;
	if (tcsetattr(__fb_con.h_in, TCSANOW, &term_in))
		return -1;

	/* Don't block */
	__fb_con.old_in_flags = fcntl(__fb_con.h_in, F_GETFL, 0);
	fcntl(__fb_con.h_in, F_SETFL, __fb_con.old_in_flags | O_NONBLOCK);

#ifdef HOST_LINUX
	if (__fb_con.inited == INIT_CONSOLE)
		fb_hTermOut(SEQ_INIT_CHARSET, 0, 0);
#endif
	fb_hTermOut(SEQ_INIT_KEYPAD, 0, 0);

	/* Initialize keyboard and mouse handlers if set */
	BG_LOCK();
	if (__fb_con.keyboard_init)
		__fb_con.keyboard_init();
	if (__fb_con.mouse_init)
		__fb_con.mouse_init();
	BG_UNLOCK();

	return 0;
}

void fb_hExitConsole( void )
{
	int bottom;
	SIGHANDLER old_sigttou_handler;

	if (__fb_con.inited) {

		/* Ignore SIGTTOU, which is sent in case we write to the
		   terminal while being in the background (e.g. CTRL+Z + bg).
		   This happens at least with the tcsetattr() on STDOUT_FILENO
		   for restoring the original terminal state below, because we
		   switched to non-canonical mode in fb_hInitConsole (~ICANON).

		   The default handler for SIGTTOU suspends the process,
		   but we don't want to hang now when exiting the FB program.

		   We probably shouldn't ignore SIGTTOU (or SIGTTIN for that
		   matter) globally/always though, as normally the behaviour
		   makes sense: If a background program tries to write to the
		   terminal (or read user input), it should be suspended until
		   brought to foreground by the user. Otherwise it would
		   interfere with whatever the user is currently doing.

		   However, implicit terminal adjustments done by the rtlib is a
		   case where we probably don't want that to happen. Thus the
		   signal should be ignored only here. */
		old_sigttou_handler = signal(SIGTTOU, SIG_IGN);

		if (__fb_con.gfx_exit)
			__fb_con.gfx_exit();
		
		BG_LOCK();
		if (__fb_con.keyboard_exit)
			__fb_con.keyboard_exit();
		if (__fb_con.mouse_exit)
			__fb_con.mouse_exit();
		BG_UNLOCK();

		/* Only restore scrolling region if we changed it. This way we can avoid
		   calling fb_ConsoleGetMaxRow(), which may have to query the terminal size.
		   It's best to avoid that as much as possible (not all terminals support
		   the escape sequence, it's slow, it's unsafe if fb_hExitConsole() is called
		   during a signal handler). */
		if (__fb_con.scroll_region_changed) {
			bottom = fb_ConsoleGetMaxRow();
			if ((fb_ConsoleGetTopRow() != 0) || (fb_ConsoleGetBotRow() != bottom - 1)) {
				/* Restore scrolling region to whole screen and clear */
				fb_hTermOut(SEQ_SCROLL_REGION, bottom - 1, 0);
				fb_hTermOut(SEQ_CLS, 0, 0);
				fb_hTermOut(SEQ_HOME, 0, 0);
			}
			__fb_con.scroll_region_changed = FALSE;
		}

		/* Cleanup terminal */
#ifdef HOST_LINUX
		if (__fb_con.inited == INIT_CONSOLE)
			fb_hTermOut(SEQ_EXIT_CHARSET, 0, 0);
#endif
		fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
		fb_hTermOut(SEQ_SHOW_CURSOR, 0, 0);
		fb_hTermOut(SEQ_EXIT_KEYPAD, 0, 0);
		tcsetattr( STDOUT_FILENO, TCSANOW, &__fb_con.old_term_out );

		/* Restore old console keyboard state */
		fcntl(__fb_con.h_in, F_SETFL, __fb_con.old_in_flags);
		tcsetattr(__fb_con.h_in, TCSANOW, &__fb_con.old_term_in);

		if (__fb_con.f_in) {
			fclose(__fb_con.f_in);
			__fb_con.f_in = NULL;
		}

		/* Restore SIGTTOU handler (so it's no longer ignored) */
		signal(SIGTTOU, old_sigttou_handler);
	}
}

static void hInit( void )
{
	const int sigs[] = { SIGABRT, SIGFPE, SIGILL, SIGSEGV, SIGTERM, SIGINT, SIGQUIT, -1 };
	char buffer[2048], *p, *term;
	struct termios tty;
    int i;

    pthread_mutexattr_t attr;

#if defined(__GNUC__) && defined(__i386__)
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );
#endif

	/* make mutex recursive to behave the same on Win32 and Linux (if possible) */
	pthread_mutexattr_init(&attr);

	/* TODO: Figure out which Unixy systems have/don't have PTHREAD_MUTEX_RECURSIVE[_NP] */
	/* Currently it seems that PTHREAD_MUTEX_RECURSIVE is the standard POSIX name,
	   while PTHREAD_MUTEX_RECURSIVE_NP is something non-posixy used on Linux.
	   Some Linux distros (or glibc/pthread versions) only seemed to make the *_NP
	   version available (at least this was observed in the past). */
#ifdef HOST_LINUX
	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);
#else
	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
#endif

#ifdef ENABLE_MT
	/* Init multithreading support */
	pthread_mutex_init(&__fb_global_mutex, &attr);
	pthread_mutex_init(&__fb_string_mutex, &attr);
	pthread_mutex_init(&__fb_graphics_mutex, &attr);
#endif

	pthread_mutex_init(&__fb_bg_mutex, &attr);

	memset(&__fb_con, 0, sizeof(__fb_con));

	/* Init termcap */
	term = getenv("TERM");
	if ((!term) || (tgetent(buffer, term) <= 0))
		return;
	BC = UP = 0;
	p = tgetstr("pc", NULL);
	PC = p ? *p : 0;
	if (tcgetattr(1, &tty))
		return;
	ospeed = cfgetospeed(&tty);
	if (!tgetflag("am"))
		return;
	for (i = 0; i < SEQ_MAX; i++)
		__fb_con.seq[i] = tgetstr(seq[i], NULL);

	/* !!!TODO!!! detect other OS consoles? (freebsd: 'cons25', etc?) */
	if ((!strcmp(term, "console")) || (!strncmp(term, "linux", 5)))
		__fb_con.inited = INIT_CONSOLE;
	else
		__fb_con.inited = INIT_X11;

	if (!strncasecmp(term, "eterm", 5))
		__fb_con.term_type = TERM_ETERM;
	else if (!strncmp(term, "xterm", 5))
		__fb_con.term_type = TERM_XTERM;
	else
		__fb_con.term_type = TERM_GENERIC;

	if (fb_hInitConsole()) {
		__fb_con.inited = FALSE;
		return;
	}
	__fb_con.keyboard_getch = default_getch;

	/* Install signal handlers to quietly shut down */
	for (i = 0; sigs[i] >= 0; i++)
		old_sighandler[sigs[i]] = signal(sigs[i],  signal_handler);

	__fb_con.char_buffer = NULL;
	__fb_con.fg_color = 7;
	__fb_con.bg_color = 0;

	/* Trigger console window size & cursor position checks the first time
	   fb_hRecheckConsoleSize() is invoked (lazy initialization).

	   It's good to do this lazily because we don't need this information
	   until the first use of one of FB's console I/O commands anyways.
	   For FB programs which don't use those we never have to bother
	   retrieving this information from the terminal.

	   This is also good because we may try to use some special terminal
	   escape sequences which the terminal may not support, in which case
	   we end up hanging, waiting for an answer forever (fb_hTermOut() and
	   fb_hTermQuery()). In that case, at least, we'll only hang when the
	   FB program uses console I/O commands, but not always on start up of
	   every FB program. */
	__fb_console_resized = TRUE;

	/* In case it's not possible to retrieve the real cursor position from
	   the terminal, we assume to start out at 1,1. */
	__fb_con.cur_y = __fb_con.cur_x = 1;

	signal(SIGWINCH, sigwinch_handler);
}

void fb_hInit( void )
{
	hInit( );

#if defined HOST_LINUX && (defined HOST_X86 || defined HOST_X86_64)
	/* Permissions for port I/O */
	__fb_con.has_perm = ioperm(0, 0x400, 1) ? FALSE : TRUE;
#endif
}

void fb_hEnd( int unused )
{
	fb_hExitConsole();
	__fb_con.inited = FALSE;
	if( bgthread_inited ) {
		pthread_join(__fb_bg_thread, NULL);
		bgthread_inited = FALSE;
	}
	pthread_mutex_destroy(&__fb_bg_mutex);

#ifdef ENABLE_MT
	/* Release multithreading support resources */
	pthread_mutex_destroy(&__fb_global_mutex);
	pthread_mutex_destroy(&__fb_string_mutex);
	pthread_mutex_destroy(&__fb_graphics_mutex);
#endif
}
