/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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

#ifndef __CYGWIN__
extern char fb_commandline[];
#endif

#ifdef MULTITHREADED
pthread_mutex_t fb_global_mutex;
pthread_mutex_t fb_string_mutex;
#endif

FBCONSOLE fb_con;


static void (*old_sigabrt)(int);
static void (*old_sigfpe) (int);
static void (*old_sigill) (int);
static void (*old_sigsegv)(int);
static void (*old_sigterm)(int);
static void (*old_sigint) (int);
static void (*old_sigquit)(int);
static const char color_map[16]= { 0, 4, 2, 6, 1, 5, 3, 7, 8, 12, 10, 14, 9, 13, 11, 15 };
static const unsigned char color[] =  { 0x00, 0x00, 0x00, 0x00, 0x00, 0xA8, 0x00, 0xA8, 0x00, 0x00, 0xA8, 0xA8,
					0xA8, 0x00, 0x00, 0xA8, 0x00, 0xA8, 0xA8, 0x54, 0x00, 0xA8, 0xA8, 0xA8,
					0x54, 0x54, 0x54, 0x54, 0x54, 0xFC, 0x54, 0xFC, 0x54, 0x54, 0xFC, 0xFC,
					0xFC, 0x54, 0x54, 0xFC, 0x54, 0xFC, 0xFC, 0xFC, 0x54, 0xFC, 0xFC, 0xFC };


/*:::::*/
static void signal_handler(int sig)
{
	signal(SIGABRT, old_sigabrt);
	signal(SIGFPE,  old_sigfpe);
	signal(SIGILL,  old_sigill);
	signal(SIGSEGV, old_sigsegv);
	signal(SIGTERM, old_sigterm);
	signal(SIGINT,  old_sigint);
	signal(SIGQUIT, old_sigquit);

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
		fputs("\e[18t", fb_con.f_out);
		if (fscanf(fb_con.f_in, "\e[8;%d;%dt", &r, &c) == 2) {
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
	fputs("\e[6n", fb_con.f_out);
	fscanf(stdin, "\e[%d;%dR", &fb_con.cur_y, &fb_con.cur_x);

	fb_con.resized = FALSE;
}


/*:::::*/
int fb_hInitConsole ( int init )
{
	struct termios term_out, term_in;
	int i;

	/* Init terminal I/O */
	fb_con.h_out = fileno(stdout);
	fb_con.h_in = fileno(stdin);
	fb_con.f_out = stdout;
	fb_con.f_in = stdin;
	if (!isatty(fb_con.h_out) || !isatty(fb_con.h_in))
		return -1;

	/* Output setup */
	if (tcgetattr(fb_con.h_out, &fb_con.old_term_out))
		return -1;
	memcpy(&term_out, &fb_con.old_term_out, sizeof(term_out));
	term_out.c_oflag |= OPOST;
	if (tcsetattr(fb_con.h_out, TCSAFLUSH, &term_out))
		return -1;

	/* Input setup */
	if (init != INIT_CONSOLE) {
		fb_con.f_in = fopen("/dev/tty", "r+b");
		if (!fb_con.f_in)
			return -1;
		fb_con.h_in = fileno(fb_con.f_in);
	}
	if (tcgetattr(fb_con.h_in, &fb_con.old_term_in))
		return -1;
	memcpy(&term_in, &fb_con.old_term_in, sizeof(term_in));
	/* Ignore breaks */
	term_in.c_iflag |= (IGNBRK | BRKINT);
	/* Disable Xon/off */
	term_in.c_iflag &= ~(IXOFF | IXON);
	/* Character oriented, no echo */
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

	if (init == INIT_CONSOLE) {
		/* Set our default palette */
		for (i = 0; i < 16; i++)
			fprintf(fb_con.f_out, "\e]P%1.1X%2.2X%2.2X%2.2X", color_map[i], color[i*3], color[(i*3)+1], color[(i*3)+2]);
	}
	fb_con.fg_color = 0x7;
	/* Set IBM PC 437 charset */
	fputs("\e(U", fb_con.f_out);

	return 0;
}


/*:::::*/
void fb_hInit ( int argc, char **argv )
{
#ifdef MULTITHREADED
    pthread_mutexattr_t attr;
#endif
	int init = FALSE;
    char *term;
#ifndef __CYGWIN__
    int i;
#endif

#ifndef __CYGWIN__
	/* rebuild command line from argv */
	fb_commandline[0] = '\0';
	for( i = 0; i < argc; i++ )
	{
		strncat( fb_commandline, argv[i], 1024 );
		if( i != argc-1 )
			strncat( fb_commandline, " ", 1024 );
    }
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
	pthread_key_create(&fb_errctx.reslbl,    NULL);
	pthread_key_create(&fb_errctx.resnxtlbl, NULL);

	/* allocate thread local storage vars for input context */
	pthread_key_create(&fb_inpctx.f,         NULL);
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
#endif

	memset(&fb_con, 0, sizeof(fb_con));

	term = getenv("TERM");
	if ((term) && ((!strcmp(term, "console")) || (!strncmp(term, "linux", 5))))
		init = INIT_CONSOLE;
	if ((term) && (!strncmp(term, "xterm", 5)))
		init = INIT_XTERM;
	if ((term) && (!strncasecmp(term, "eterm", 5)))
		init = INIT_ETERM;
	if (!init)
		return;

	if (fb_hInitConsole(init))
		return;
	fb_con.inited = init;

	/* Install signal handlers to quietly shut down */
	old_sigabrt = signal(SIGABRT, signal_handler);
	old_sigfpe  = signal(SIGFPE,  signal_handler);
	old_sigill  = signal(SIGILL,  signal_handler);
	old_sigsegv = signal(SIGSEGV, signal_handler);
	old_sigterm = signal(SIGTERM, signal_handler);
	old_sigint  = signal(SIGINT,  signal_handler);
	old_sigquit = signal(SIGQUIT, signal_handler);
	signal(SIGWINCH, console_resize);

	fb_con.char_buffer = NULL;
	fb_con.resized = TRUE;
	fb_hResize();
}
