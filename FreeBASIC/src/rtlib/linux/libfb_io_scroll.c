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
 * io_scroll.c -- console scrolling for when VIEW is used for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb.h"

#ifndef DISABLE_NCURSES
#include <curses.h>
#endif

/*:::::*/
void fb_ConsoleScroll( int nrows )
{
    int toprow, botrow;
    int cols, rows;
#ifndef DISABLE_NCURSES
	WINDOW *view;
	int i;
#endif

    if( nrows <= 0 )
    	return;

    fb_ConsoleGetSize( &cols, &rows );
    fb_ConsoleGetView( &toprow, &botrow );

#ifndef DISABLE_NCURSES

	view = subwin(stdscr, botrow - toprow + 1, getmaxx(stdscr), toprow - 1, 0);
	scrollok(view, TRUE);
	wscrl(view, nrows);
	touchwin(stdscr);
	for (; nrows; nrows--) {
		move(botrow - nrows, 0);
    	for (i = getmaxx(stdscr); i; i--)
    	    addch(' ');
	}

	refresh();
	delwin(view);

#endif

}
