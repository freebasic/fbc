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
 * io_color.c -- color (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb.h"
#include "fb_colors.h"

#ifndef DISABLE_NCURSES
#include <curses.h>
#endif

/* globals */
int fb_last_bc = 0,
	fb_last_fc = 15;


/*:::::*/
void fb_ConsoleColor( int fc, int bc )
{
#ifndef DISABLE_NCURSES
	int pair;

	if (!has_colors())
		return;

	if (fc >= 0)
		fb_last_fc = (fc & 0xf);
	if (bc >= 0)
		fb_last_bc = (bc & 0x7);

	pair = ((fb_last_fc & 0x7) | (fb_last_bc << 3));
	attrset(COLOR_PAIR(pair) | (fb_last_fc & 0x8 ? A_BOLD : 0));
#endif

}

/*:::::*/
int fb_ConsoleGetColorAtt( void )
{
	int res = 0;

#ifndef DISABLE_NCURSES
	attr_t attr;
	short pair;

	attr_get(&attr, &pair, NULL);
	res = (pair & 0x7) | (attr & A_BOLD ? 0x8 : 0) | ((pair & 0x38) << 4);
#endif

	return res;

}
