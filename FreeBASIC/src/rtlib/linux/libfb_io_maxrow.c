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
 * io_maxrow.c -- get max row (console, no gfx) for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"


/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
	struct winsize win;
	int r, c;
	
	if (!fb_con.inited)
		return 25;
	
	win.ws_row = 0xFFFF;
	ioctl(fb_con.h_out, TIOCGWINSZ, &win);
	if (win.ws_row == 0xFFFF) {
		fputs("\e[18t", fb_con.f_out);
		if (fscanf(fb_con.f_in, "\e[8;%d;%dt", &r, &c) == 2)
			return r;
		return 25;
	}
	return win.ws_row;
}
