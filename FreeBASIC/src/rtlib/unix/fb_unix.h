/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * fb_unix.h -- unix base target-specific header
 *
 * chng: jul/2007 written [DrV]
 *
 */

#ifndef __FB_UNIX_H__
#define __FB_UNIX_H__

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdarg.h>
#include <signal.h>
#include <termios.h>
#include <dirent.h>
#include <dlfcn.h>
#include <pthread.h>

#ifdef WITH_X
#include <X11/Xlib.h>
#include <X11/keysym.h>
#endif

#ifdef HAVE_TERMCAP_H
# include <termcap.h>
#endif

#ifdef HAVE_SYS_IO_H
# include <sys/io.h>
#endif
#include <sys/ioctl.h>

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

#ifdef TARGET_LINUX
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

extern int fb_hTermOut( int code, int param1, int param2);
extern int fb_hGetCh(int remove);
extern int fb_hXTermInitFocus(void);
extern void fb_hXTermExitFocus(void);
extern int fb_hXTermHasFocus(void);
extern int fb_hConsoleGfxMode(void (*gfx_exit)(void), void (*save)(void), void (*restore)(void), void (*key_handler)(int));


#ifdef MULTITHREADED
extern pthread_mutex_t __fb_global_mutex;
extern pthread_mutex_t __fb_string_mutex;
# define FB_LOCK()					pthread_mutex_lock(&__fb_global_mutex)
# define FB_UNLOCK()				pthread_mutex_unlock(&__fb_global_mutex)
# define FB_STRLOCK()				pthread_mutex_lock(&__fb_string_mutex)
# define FB_STRUNLOCK()				pthread_mutex_unlock(&__fb_string_mutex)
# define FB_TLSENTRY				pthread_key_t
# define FB_TLSALLOC(key) 			pthread_key_create( &(key), NULL )
# define FB_TLSFREE(key)			pthread_key_delete( (key) )
# define FB_TLSSET(key,value)		pthread_setspecific((key), (const void *)(value))
# define FB_TLSGET(key)				pthread_getspecific((key))
#endif

#define FB_THREADID pthread_t

#define FB_DYLIB void*

typedef struct _FB_DIRCTX
{
	int in_use;
	int attrib;
	DIR *dir;
	char filespec[MAX_PATH];
	char dirname[MAX_PATH];
} FB_DIRCTX;

typedef off_t fb_off_t;

typedef struct _FBMUTEX {
	pthread_mutex_t id;
} FBMUTEX;

extern int fb_hInitConsole(void);
extern void fb_hExitConsole(void);

extern void fb_unix_hInit ( void );
extern void fb_unix_hEnd ( int unused );

#ifdef WITH_X
typedef struct KeysymToScancode {
  KeySym keysym;
  int scancode;
} KeysymToScancode;

extern const KeysymToScancode fb_keysym_to_scancode[];
#endif

#endif
