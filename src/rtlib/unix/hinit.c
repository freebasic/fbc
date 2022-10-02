/* libfb initialization for Unix */

/* for getpgid() and PTHREAD_MUTEX_RECURSIVE */
#define _GNU_SOURCE 1

#include "../fb.h"
#include "fb_private_console.h"
#include "../fb_private_thread.h"
#include <signal.h>
#include <termcap.h>

#if defined HOST_LINUX && (defined HOST_X86 || defined HOST_X86_64)
	/*
	The sys/ headers are architecture and OS dependent. They 
	do not exist across all targets and io.h in particular 
	is intended for very low-level non-portable uses often 
	in coordination with the kernel. The only targets that 
	provide sys/io.h are x86*, Alpha, IA64, and 32-bit ARM.
	No other systems provide it.
	From https://bugzilla.redhat.com/show_bug.cgi?id=1116162
	or http://www.hep.by/gnu/gnulib/ioperm.html#ioperm
	*/
	#include <sys/io.h>
#endif

#include <sys/ioctl.h>
#include <fcntl.h>

FBCONSOLE __fb_con;

typedef void (*SIGHANDLER)(int);
static SIGHANDLER old_sighandler[NSIG];
static volatile sig_atomic_t __fb_console_resized;
static const char *seq[] = {
	"cm", /* SEQ_LOCATE        */
	"ho", /* SEQ_HOME          */
	"cs", /* SEQ_SCROLL_REGION */
	"cl", /* SEQ_CLS           */
	"ce", /* SEQ_CLEOL         */
	"WS", /* SEQ_WINDOW_SIZE   */
	"bl", /* SEQ_BEEP          */
	"AF", /* SEQ_FG_COLOR      */
	"AB", /* SEQ_BG_COLOR      */
	"me", /* SEQ_RESET_COLOR   */
	"md", /* SEQ_BRIGHT_COLOR  */
	"SF", /* SEQ_SCROLL        */
	"ve", /* SEQ_SHOW_CURSOR   */
	"vi", /* SEQ_HIDE_CURSOR   */
	"dc", /* SEQ_DEL_CHAR      */
	"ks", /* SEQ_INIT_KEYPAD   */
	"ke", /* SEQ_EXIT_KEYPAD   */
};

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
static pthread_mutex_t __fb_math_mutex;
FBCALL void fb_Lock     ( void ) { pthread_mutex_lock  ( &__fb_global_mutex ); }
FBCALL void fb_Unlock   ( void ) { pthread_mutex_unlock( &__fb_global_mutex ); }
FBCALL void fb_StrLock  ( void ) { pthread_mutex_lock  ( &__fb_string_mutex ); }
FBCALL void fb_StrUnlock( void ) { pthread_mutex_unlock( &__fb_string_mutex ); }
FBCALL void fb_GraphicsLock  ( void ) { pthread_mutex_lock  ( &__fb_graphics_mutex ); }
FBCALL void fb_GraphicsUnlock( void ) { pthread_mutex_unlock( &__fb_graphics_mutex ); }
FBCALL void fb_MathLock  ( void ) { pthread_mutex_lock  ( &__fb_math_mutex ); }
FBCALL void fb_MathUnlock( void ) { pthread_mutex_unlock( &__fb_math_mutex ); }
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
static int fb_hTermQuery( int code, int *val1, int *val2 )
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
	if( ioctl( STDOUT_FILENO, TIOCGWINSZ, &win ) != 0 ) {
#ifdef HOST_LINUX
		/* Try an escape sequence */
		int r, c;
		if( fb_hTermQuery( SEQ_QUERY_WINDOW, &r, &c ) ) {
			win.ws_row = r;
			win.ws_col = c;
		}
#endif
	}

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

	fb_DevScrnMaybeUpdateWidth( );
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
	const char *extra_seq[] = {
		"\e(U",               /* SEQ_INIT_CHARSET */
		"\e(B",               /* SEQ_EXIT_CHARSET */
		"\e[6n",              /* SEQ_QUERY_CURSOR */
		"\e[18t",             /* SEQ_QUERY_WINDOW */
		"\e[?1000h\e[?1003h", /* SEQ_INIT_XMOUSE */
		"\e[?1003l\e[?1000l", /* SEQ_EXIT_XMOUSE */
		"\e[H\e[J\e[0m",      /* SEQ_EXIT_GFX_MODE */
	};

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

/**
 * (Re-)configure the I/O tty as required for FB runtime functionality
 *
 * fb_hInitConsole() and fb_hExitConsole() are not only used at start/exit of
 * an FB process, but also to temporarily undo the configuration when running
 * sub-processes in shell()/exec()/chain()/run() or loading or unloading shared
 * libraries in dylibload()/dylibfree().
 *
 * On the one hand this is needed if the sub-process is a program which
 * requires normal terminal behaviour to work properly. run() is a particularly
 * good example, because it exec()s another program without fork()ing, so we
 * do not have a chance to clean-up anymore and must do it before that.
 * Another reason is to allow the sub-process or shared library to see the
 * original terminal state as we saw it, so in case it contains an FB runtime,
 * it can capture the original terminal state and restore it properly if its
 * cleanup runs after ours (with shared libraries that can happen because their
 * global dtor responsible for calling fb_hEnd() may run after ours, and with
 * sub-processes it can happen if they outlive us). We want correct terminal
 * clean-up either way, for example to not leave echoing disabled on exit of
 * the last process.
 *
 * On the other hand, temporarily disabling the custom tty configuration could
 * be problematic especially in a multi-threaded program, because for example
 * INKEY() may not work properly anymore in parallel to SHELL().
 * Even though the callers of fb_hExitConsole()/fb_hInitConsole() ensure basic
 * thread-safety by wrapping each call in FB_LOCK()/FB_UNLOCK(), they only lock
 * the lock for the duration of the single call, not both calls together.
 * Otherwise the lock would be held for the entire duration of the
 * shell()/exec() call, which would not be desirable for long-running
 * sub-processes and a multi-threaded FB program.
 *
 * Because of the "incomplete" locking, it's easily possible for calls to
 * fb_hInitConsole()/fb_hExitConsole() to be unbalanced. fb_hInitConsole() may
 * be called multiple times in a row; fb_hExitConsole() is not guaranteed to be
 * called in between.
 *
 * Similar problems can probably happen with multiple processes "fighting" over
 * the terminal.
 * Naturally, the problems also exist and cannot be avoided if FB programs use
 * the libc functions such as dlopen() and fork()/exec() directly, instead of
 * the FB keywords.
 */
int fb_hInitConsole(void)
{
	struct termios term_out, term_in;

	if (!__fb_con.inited)
		return -1;

	/* Init terminal I/O */
	if( !isatty( STDOUT_FILENO ) || !isatty( STDIN_FILENO ) )
		return -1;
	if (!__fb_con.f_in) {
		__fb_con.f_in = fopen("/dev/tty", "r+b");
		if (!__fb_con.f_in)
			return -1;
		__fb_con.h_in = fileno(__fb_con.f_in);
	}
	
	/* Cannot control console if process was started in background */
	if( tcgetpgrp( STDOUT_FILENO ) != getpgid( 0 ) )
		return -1;

	/* On first run in this process, capture the original in/out tty states
	   before modifying them, so we can restore them on process exit.
	   On subsequent invocations, it's not necessary to capture it again,
	   since we already have it.
	   We can only be sure to see the original state during the first run
	   from fb_hInit(). Subsequent invocations may see our own state in
	   case of improperly balanced fb_hExitConsole()/fb_hInitConsole()
	   calls from multi-threaded uses of fb_hShell() etc. */

	/* Output setup */
	if (!__fb_con.saved_old_term_out) {
		if (tcgetattr(STDOUT_FILENO, &__fb_con.old_term_out))
			return -1;
		__fb_con.saved_old_term_out = true;
	}
	memcpy(&term_out, &__fb_con.old_term_out, sizeof(term_out));
	term_out.c_oflag |= OPOST;
	if( tcsetattr( STDOUT_FILENO, TCSANOW, &term_out ) )
		return -1;

	/* Input setup */
	if (!__fb_con.saved_old_term_in) {
		if (tcgetattr(__fb_con.h_in, &__fb_con.old_term_in))
			return -1;
		__fb_con.saved_old_term_in = true;
	}
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
	if (!__fb_con.saved_old_in_flags) {
		__fb_con.old_in_flags = fcntl(__fb_con.h_in, F_GETFL, 0);
		__fb_con.saved_old_in_flags = true;
	}
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

/* Undo I/O tty configuration - restore it to the original state. See also fb_hInitConsole(). */
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

		/* Restore in/out tty to the saved state, if we have any.
		   The saved state is kept around even after this,
		   in case this is not the final fb_hExitConsole() call.
		   This is OK because it does not involve leaking anything.
		   We have to fclose() the f_in FILE* though to avoid a leak. */

		/* Cleanup terminal */
#ifdef HOST_LINUX
		if (__fb_con.inited == INIT_CONSOLE)
			fb_hTermOut(SEQ_EXIT_CHARSET, 0, 0);
#endif
		fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
		fb_hTermOut(SEQ_SHOW_CURSOR, 0, 0);
		fb_hTermOut(SEQ_EXIT_KEYPAD, 0, 0);
		if (__fb_con.saved_old_term_out) {
			tcsetattr(STDOUT_FILENO, TCSANOW, &__fb_con.old_term_out);
		}

		/* Restore old console keyboard state */
		if (__fb_con.saved_old_in_flags) {
			fcntl(__fb_con.h_in, F_SETFL, __fb_con.old_in_flags);
		}
		if (__fb_con.saved_old_term_in) {
			tcsetattr(__fb_con.h_in, TCSANOW, &__fb_con.old_term_in);
		}

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
	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

#ifdef ENABLE_MT
	/* Init multithreading support */
	pthread_mutex_init(&__fb_global_mutex, &attr);
	pthread_mutex_init(&__fb_string_mutex, &attr);
	pthread_mutex_init(&__fb_graphics_mutex, &attr);
	pthread_mutex_init(&__fb_math_mutex, &attr);
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
		__fb_con.seq[i] = tgetstr((char*)seq[i], NULL);

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

	if (__fb_con.char_buffer) {
		free(__fb_con.char_buffer);
		__fb_con.char_buffer = NULL;
		__fb_con.attr_buffer = NULL;
	}

#ifdef ENABLE_MT
	/* Release multithreading support resources */
	pthread_mutex_destroy(&__fb_global_mutex);
	pthread_mutex_destroy(&__fb_string_mutex);
	pthread_mutex_destroy(&__fb_graphics_mutex);
	pthread_mutex_destroy(&__fb_math_mutex);
#endif
}
