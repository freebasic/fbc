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
 * io_locate.c -- locate (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb.h"

#ifndef DISABLE_NCURSES
#include <curses.h>
#endif

/*:::::*/
void fb_ConsoleLocate( int row, int col, int cursor )
{
#ifndef DISABLE_NCURSES
	int x, y;

	if (col > 0)
		x = col - 1;
	else
		x = getcurx(stdscr);

	if (row > 0)
		y = row - 1;
	else
		y = getcury(stdscr);

	if (cursor >= 0)
		curs_set(cursor ? 1 : 0);

	move(y, x);
	refresh();
#endif
}


/*:::::*/
int fb_ConsoleGetX( void )
{
#ifndef DISABLE_NCURSES
	return getcurx(stdscr) + 1;
#else
	return 0;
#endif
}

/*:::::*/
int fb_ConsoleGetY( void )
{
#ifndef DISABLE_NCURSES
	return getcury(stdscr) + 1;
#else
	return 0;
#endif
}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
#ifndef DISABLE_NCURSES
	if (col != NULL)
		*col = getcurx(stdscr) + 1;
	if (row != NULL)
		*row = getcury(stdscr) + 1;
#endif
}

