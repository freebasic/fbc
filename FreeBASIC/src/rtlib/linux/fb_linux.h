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
#include <dlfcn.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

#define INIT_CONSOLE	1
#define INIT_XTERM	2
#define INIT_ETERM	3


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
} FBCONSOLE;

extern FBCONSOLE fb_con;


extern int fb_hGetCh();
extern void fb_hResize();


#endif
