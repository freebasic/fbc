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
 * fb_linux.h -- linux specific console stuff.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#ifndef __FB_LINUX_H__
#define __FB_LINUX_H__

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
#include <sys/mman.h>
#include <sys/io.h>
#include <sys/ioctl.h>

#define INIT_CONSOLE		1
#define INIT_XTERM			2
#define INIT_ETERM			3

#define BG_LOCK()			pthread_mutex_lock(&fb_con.bg_mutex);
#define BG_UNLOCK()			pthread_mutex_unlock(&fb_con.bg_mutex);

#ifdef MULTITHREADED
extern pthread_mutex_t fb_global_mutex;
extern pthread_mutex_t fb_string_mutex;
# define FB_LOCK()					pthread_mutex_lock(&fb_global_mutex)
# define FB_UNLOCK()				pthread_mutex_unlock(&fb_global_mutex)
# define FB_STRLOCK()				pthread_mutex_lock(&fb_string_mutex)
# define FB_STRUNLOCK()				pthread_mutex_unlock(&fb_string_mutex)
# define FB_TLSENTRY				pthread_key_t
# define FB_TLSSET(key,value)		pthread_setspecific((key), (const void *)(value))
# define FB_TLSGET(key)				pthread_getspecific((key))
#endif

typedef struct _FB_DIRCTX
{
	int in_use;
	int attrib;
	DIR *dir;
	char filespec[MAX_PATH];
	char dirname[MAX_PATH];
} FB_DIRCTX;

typedef struct FBCONSOLE
{
	int inited;
	int h_out, h_in;
	FILE *f_out, *f_in;
	struct termios old_term_out, old_term_in;
	int in_flags, old_in_flags;
	int fg_color, bg_color;
	int cur_x, cur_y;
	int w, h, resized;
	unsigned char *char_buffer, *attr_buffer;
	pthread_t bg_thread;
	pthread_mutex_t bg_mutex;
	int has_perm;
	int (*keyboard_getch)(void);
	int (*keyboard_init)(void);
	void (*keyboard_exit)(void);
	void (*keyboard_handler)(void);
	int (*mouse_init)(void);
	void (*mouse_exit)(void);
	void (*mouse_handler)(void);
	void (*mouse_update)(int cb, int cx, int cy);
} FBCONSOLE;

extern FBCONSOLE fb_con;

extern int fb_hGetCh(int remove);
extern void fb_hResize(void);
extern int fb_hInitConsole(int);
extern void fb_hExitConsole(void);
extern int fb_hXTermInitFocus(void);
extern void fb_hXTermExitFocus(void);
extern int fb_hXTermHasFocus(void);

#endif
