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
FBCALL void fb_Lock     ( void ) { pthread_mutex_lock  ( &__fb_global_mutex ); }
FBCALL void fb_Unlock   ( void ) { pthread_mutex_unlock( &__fb_global_mutex ); }
FBCALL void fb_StrLock  ( void ) { pthread_mutex_lock  ( &__fb_string_mutex ); }
FBCALL void fb_StrUnlock( void ) { pthread_mutex_unlock( &__fb_string_mutex ); }
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
int fb_hTermQuery( int code, int *val1, int *val2 )
{
	if( fb_hTermOut( code, 0, 0 ) == FALSE )
		return FALSE;

	if( (code != SEQ_QUERY_WINDOW) && (code != SEQ_QUERY_CURSOR) )
		return FALSE;

	/* The terminal should have sent its reply through stdin. However, it's
	   possible that there's other data pending in stdin, e.g. if the user
	   happened to press a key at the right time. */

	/* Read until an ESC char is reached (ESC should be the begin of the
	   terminal's answer string) */
	int c;
	do {
		c = getchar( );
		if( c == EOF )
			return FALSE;
	} while (c != '\e');

	if( code == SEQ_QUERY_WINDOW )
		return (fscanf( stdin, "[8;%d;%dt", val1, val2 ) == 2);

	/* SEQ_QUERY_CURSOR */
	return (fscanf( stdin, "[%d;%dR", val1, val2 ) == 2);
}
#endif

/* If the SIGWINCH handler was called, re-query terminal width/height
   - Assuming BG_LOCK() is acquired, because this can be called from
     linux/io_mouse.c:mouse_handler() from the background thread
   - Assuming __fb_con.inited */
void fb_hRecheckConsoleSize( void )
{
	unsigned char *char_buffer, *attr_buffer;
	struct winsize win;
	int r, c, w, h;

	if( __fb_console_resized == FALSE )
		return;

	__fb_console_resized = FALSE;

	/* __fb_console_resized may be set to TRUE again here if the signal
	   handler is called right now, but it doesn't matter since we're about
	   to update anyways */

	win.ws_row = 0xFFFF;
	ioctl( STDOUT_FILENO, TIOCGWINSZ, &win );
	if (win.ws_row == 0xFFFF) {
#ifdef HOST_LINUX
		if( fb_hTermQuery( SEQ_QUERY_WINDOW, &r, &c ) ) {
			win.ws_row = r;
			win.ws_col = c;
		}
		else
#endif
		{
			win.ws_row = 25;
			win.ws_col = 80;
		}
	}

	char_buffer = calloc(1, win.ws_row * win.ws_col * 2);
	attr_buffer = char_buffer + (win.ws_row * win.ws_col);
	if (__fb_con.char_buffer) {
		h = (__fb_con.h < win.ws_row) ? __fb_con.h : win.ws_row;
		w = (__fb_con.w < win.ws_col) ? __fb_con.w : win.ws_col;
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
#ifdef HOST_LINUX
	if( fb_hTermQuery( SEQ_QUERY_CURSOR, &__fb_con.cur_y, &__fb_con.cur_x ) == FALSE )
#endif
	{
		__fb_con.cur_y = __fb_con.cur_x = 1;
	}

	/* If __fb_console_resized is set to TRUE only now (after the above
	   check) then we will miss it for now, but it's ok because the next
	   fb_hRecheckConsoleSize() will handle it. */
}

static void sigwinch_handler(int sig)
{
	__fb_console_resized = TRUE;
	signal(SIGWINCH, sigwinch_handler);
}

int fb_hTermOut( int code, int param1, int param2 )
{
	const char *extra_seq[] = { "\e(U", "\e(B", "\e[6n", "\e[18t",
		"\e[?1000h\e[?1003h", "\e[?1003l\e[?1000l", "\e[H\e[J\e[0m" };
	char *str;

	if (!__fb_con.inited)
		return FALSE;

	if (code > SEQ_MAX) {
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

	if (__fb_con.inited) {
		
		if (__fb_con.gfx_exit)
			__fb_con.gfx_exit();
		
		BG_LOCK();
		if (__fb_con.keyboard_exit)
			__fb_con.keyboard_exit();
		if (__fb_con.mouse_exit)
			__fb_con.mouse_exit();
		BG_UNLOCK();

		bottom = fb_ConsoleGetMaxRow();
		if ((fb_ConsoleGetTopRow() != 0) || (fb_ConsoleGetBotRow() != bottom - 1)) {
			/* Restore scrolling region to whole screen and clear */
			fb_hTermOut(SEQ_SCROLL_REGION, bottom - 1, 0);
			fb_hTermOut(SEQ_CLS, 0, 0);
			fb_hTermOut(SEQ_HOME, 0, 0);
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
	}
}

static void hInit( void )
{
	const int sigs[] = { SIGABRT, SIGFPE, SIGILL, SIGSEGV, SIGTERM, SIGINT, SIGQUIT, -1 };
	char buffer[2048], *p, *term;
	struct termios tty;
    int i;

#ifdef ENABLE_MT
    pthread_mutexattr_t attr;
#endif

#if defined(__GNUC__) && defined(__i386__)
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );
#endif

#ifdef ENABLE_MT
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

	/* Init multithreading support */
	pthread_mutex_init(&__fb_global_mutex, &attr);
	pthread_mutex_init(&__fb_string_mutex, &attr);
#endif

	pthread_mutex_init( &__fb_bg_mutex, NULL );

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

	__fb_console_resized = TRUE;
	fb_hRecheckConsoleSize( );
	signal(SIGWINCH, sigwinch_handler);
}

void fb_hInit( void )
{
	hInit( );

#ifdef HOST_LINUX
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
#endif
}
