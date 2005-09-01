/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * init.c -- libfb initialization for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"

extern char fb_commandline[];

#ifdef MULTITHREADED
pthread_mutex_t fb_global_mutex;
pthread_mutex_t fb_string_mutex;
#ifndef PTHREAD_MUTEX_RECURSIVE
#define PTHREAD_MUTEX_RECURSIVE PTHREAD_MUTEX_RECURSIVE_NP
#endif
extern int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int kind);
#endif

FBCONSOLE fb_con;

typedef void (*SIGHANDLER)(int);
static SIGHANDLER old_sighandler[NSIG];
static const char *seq[] = { "cm", "ho", "cs", "cl", "ce", "WS", "bl", "AF", "AB",
							 "me", "md", "SF", "ve", "vi", "dc", "ks", "ke" };


/*:::::*/
static void *bg_thread(void *arg)
{
	while (fb_con.inited) {

		BG_LOCK();
		if (fb_con.keyboard_handler)
			fb_con.keyboard_handler();
		if (fb_con.mouse_handler)
			fb_con.mouse_handler();
		BG_UNLOCK();

		usleep(30000);
	}
	return NULL;
}


/*:::::*/
static int default_getch(void)
{
	return fgetc(fb_con.f_in);
}


/*:::::*/
static void signal_handler(int sig)
{
	signal(sig, old_sighandler[sig]);

	fb_hEnd(1);

	raise(sig);
}


/*:::::*/
static void console_resize(int sig)
{
	fb_con.resized = TRUE;
	signal(SIGWINCH, console_resize);
}


/*:::::*/
void fb_hResize()
{
	unsigned char *char_buffer, *attr_buffer;
	struct winsize win;
	int r, c, w, h;

	if ((!fb_con.inited) || (!fb_con.resized))
		return;
	
	win.ws_row = 0xFFFF;
	ioctl(fb_con.h_out, TIOCGWINSZ, &win);
	if (win.ws_row == 0xFFFF) {
		fb_hTermOut(SEQ_QUERY_WINDOW, 0, 0);
		if (fscanf(stdin, "\e[8;%d;%dt", &r, &c) == 2) {
			win.ws_row = r;
			win.ws_col = c;
		}
		else {
			win.ws_row = 25;
			win.ws_col = 80;
		}
	}

	char_buffer = calloc(1, win.ws_row * win.ws_col * 2);
	attr_buffer = char_buffer + (win.ws_row * win.ws_col);
	if (fb_con.char_buffer) {
		h = (fb_con.h < win.ws_row) ? fb_con.h : win.ws_row;
		w = (fb_con.w < win.ws_col) ? fb_con.w : win.ws_col;
		for (r = 0; r < h; r++) {
			memcpy(char_buffer + (r * win.ws_col), fb_con.char_buffer + (r * fb_con.w), w);
			memcpy(attr_buffer + (r * win.ws_col), fb_con.attr_buffer + (r * fb_con.w), w);
		}
		free(fb_con.char_buffer);
	}
	fb_con.char_buffer = char_buffer;
	fb_con.attr_buffer = attr_buffer;
	fb_con.h = win.ws_row;
	fb_con.w = win.ws_col;
	fflush(stdin);
	fb_hTermOut(SEQ_QUERY_CURSOR, 0, 0);
	fscanf(stdin, "\e[%d;%dR", &fb_con.cur_y, &fb_con.cur_x);

	fb_con.resized = FALSE;
}


/*:::::*/
int fb_hTermOut( int code, int param1, int param2 )
{
	const char *extra_seq[] = { "\e(U", "\e(B", "\e[6n", "\e[18t", "\e[?1000h\e[?1003h", "\e[?1003l\e[?1000l" };
	char *str;
	
	if (!fb_con.inited)
		return -1;
	
	fflush(stdout);
	if (code > SEQ_MAX) {
		fputs(extra_seq[code - SEQ_EXTRA], fb_con.f_out);
	}
	else {
		if (!fb_con.seq[code])
			return -1;
		str = tgoto(fb_con.seq[code], param1, param2);
		if (!str)
			return -1;
		tputs(str, 1, putchar);
	}
	return 0;
}


/*:::::*/
int fb_hInitConsole ( )
{
	struct termios term_out, term_in;

	if (!fb_con.inited)
		return -1;
	
	/* Init terminal I/O */
	fb_con.f_out = stdout;
	fb_con.h_out = fileno(stdout);
	if (!isatty(fb_con.h_out) || !isatty(fileno(stdin)))
		return -1;
	fb_con.f_in = fopen("/dev/tty", "r+b");
	if (!fb_con.f_in)
		return -1;
	fb_con.h_in = fileno(fb_con.f_in);
	
	/* Output setup */
	if (tcgetattr(fb_con.h_out, &fb_con.old_term_out))
		return -1;
	memcpy(&term_out, &fb_con.old_term_out, sizeof(term_out));
	term_out.c_oflag |= OPOST;
	if (tcsetattr(fb_con.h_out, TCSAFLUSH, &term_out))
		return -1;

	/* Input setup */
	if (tcgetattr(fb_con.h_in, &fb_con.old_term_in))
		return -1;
	memcpy(&term_in, &fb_con.old_term_in, sizeof(term_in));
	/* Send SIGINT on control-C */
	term_in.c_iflag |= BRKINT;
	/* Disable Xon/off and input BREAK condition ignoring */
	term_in.c_iflag &= ~(IXOFF | IXON | IGNBRK);
	/* Character oriented, no echo, no signals */
	term_in.c_lflag &= ~(ICANON | ECHO);
	/* No timeout, just don't block */
	term_in.c_cc[VMIN] = 1;
	term_in.c_cc[VTIME] = 0;

	if (tcsetattr(fb_con.h_in, TCSAFLUSH, &term_in))
		return -1;
	/* Don't block */
	fb_con.old_in_flags = fcntl(fb_con.h_in, F_GETFL, 0);
	fb_con.in_flags = fb_con.old_in_flags | O_NONBLOCK;
	fcntl(fb_con.h_in, F_SETFL, fb_con.in_flags);
	
	if (fb_con.inited == INIT_CONSOLE)
		fb_hTermOut(SEQ_INIT_CHARSET, 0, 0);
	fb_hTermOut(SEQ_INIT_KEYPAD, 0, 0);

	/* Initialize keyboard and mouse handlers if set */
	BG_LOCK();
	if (fb_con.keyboard_init)
		fb_con.keyboard_init();
	if (fb_con.mouse_init)
		fb_con.mouse_init();
	BG_UNLOCK();
	
	return 0;
}


/*:::::*/
void fb_hInit ( int argc, char **argv )
{
	const int sigs[] = { SIGABRT, SIGFPE, SIGILL, SIGSEGV, SIGTERM, SIGINT, SIGQUIT, -1 };
	char buffer[2048], *p, *term;
	struct termios tty;
    int i;
	           
#ifdef MULTITHREADED
    pthread_mutexattr_t attr;
#endif

	/* rebuild command line from argv */
	fb_commandline[0] = '\0';
	for( i = 0; i < argc; i++ )
	{
		strncat( fb_commandline, argv[i], 1024 );
		if( i != argc-1 )
			strncat( fb_commandline, " ", 1024 );
    }

#if defined(__GNUC__) && defined(__i386__)
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );
#endif

#ifdef MULTITHREADED
	/* make mutex recursive to behave the same on Win32 and Linux */
	pthread_mutexattr_init(&attr);
	pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);

	/* Init multithreading support */
	pthread_mutex_init(&fb_global_mutex, &attr);
	pthread_mutex_init(&fb_string_mutex, &attr);

	/* allocate thread local storage vars for runtime error handling */
	pthread_key_create(&fb_errctx.handler,   NULL);
	pthread_key_create(&fb_errctx.num,       NULL);
	pthread_key_create(&fb_errctx.linenum,   NULL);
	pthread_key_create(&fb_errctx.reslbl,    NULL);
	pthread_key_create(&fb_errctx.resnxtlbl, NULL);

	/* allocate thread local storage vars for input context */
	pthread_key_create(&fb_inpctx.handle,    NULL);
	pthread_key_create(&fb_inpctx.i,         NULL);
	pthread_key_create(&fb_inpctx.s.data,    NULL);
	pthread_key_create(&fb_inpctx.s.len,     NULL);
	pthread_key_create(&fb_inpctx.s.size,    NULL);

	/* allocate thread local storage vars for print using context */
	pthread_key_create(&fb_printusgctx.chars,       NULL);
	pthread_key_create(&fb_printusgctx.ptr,         NULL);
	pthread_key_create(&fb_printusgctx.fmtstr.data, NULL);
	pthread_key_create(&fb_printusgctx.fmtstr.len,  NULL);
	pthread_key_create(&fb_printusgctx.fmtstr.size, NULL);
	
	/* allocate thread local storage var for dir context */
	pthread_key_create(&fb_dirctx,           NULL);
#endif

	pthread_mutex_init( &fb_con.bg_mutex, NULL );

	memset(&fb_con, 0, sizeof(fb_con));

	fb_con.has_perm = ioperm(0, 0x400, 1) ? FALSE : TRUE;
	
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
		fb_con.seq[i] = tgetstr(seq[i], NULL);
	
	if ((!strcmp(term, "console")) || (!strncmp(term, "linux", 5)))
		fb_con.inited = INIT_CONSOLE;
	else
		fb_con.inited = INIT_X11;
	if (fb_hInitConsole()) {
		fb_con.inited = FALSE;
		return;
	}
	fb_con.keyboard_getch = default_getch;

	pthread_create( &fb_con.bg_thread, NULL, bg_thread, NULL );

	/* Install signal handlers to quietly shut down */
	for (i = 0; sigs[i] >= 0; i++)
		old_sighandler[sigs[i]] = signal(sigs[i],  signal_handler);

	signal(SIGWINCH, console_resize);

	fb_con.char_buffer = NULL;
	fb_con.resized = TRUE;
	fb_hResize();
}
