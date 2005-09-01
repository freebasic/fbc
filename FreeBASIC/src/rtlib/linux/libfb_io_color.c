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
 * io_color.c -- color (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"
#include "fb_linux.h"


/*:::::*/
int fb_ConsoleColor( int fc, int bc )
{
	const char map[8] = { 0, 4, 2, 6, 1, 5, 3, 7 };
	int cur = fb_con.fg_color | (fb_con.bg_color << 16);
	
	if (!fb_con.inited)
		return cur;
	
	fb_hResize();
	
	if (fc >= 0)
		fb_con.fg_color = (fc & 0xF);
	if (bc >= 0)
		fb_con.bg_color = (bc & 0x7);
	fb_hTermOut(SEQ_RESET_COLOR, 0, 0);
	if (fb_con.fg_color & 0x8)
		fb_hTermOut(SEQ_BRIGHT_COLOR, 0, 0);
	fb_hTermOut(SEQ_FG_COLOR, 0, map[fb_con.fg_color & 0x7]);
	fb_hTermOut(SEQ_BG_COLOR, 0, map[fb_con.bg_color]);

	return cur;
}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
	return fb_con.inited ? (fb_con.fg_color | (fb_con.bg_color << 4)) : 0x7;
}
