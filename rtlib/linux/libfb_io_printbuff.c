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
 * io_printbuff.c -- low-level print to console function for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include <stdio.h>
#include "fb.h"

#ifndef DISABLE_NCURSES
#include <curses.h>
#endif

/*:::::*/
void fb_ConsolePrintBuffer( char *buffer, int mask )
{
    int col, row;
    int toprow, botrow;
	int cols, rows;
	int len, scrolloff = FALSE;
	int rowsleft, rowstoscroll;

	len = strlen( buffer );

	fb_ConsoleGetSize( &cols, &rows );
	fb_ConsoleGetView( &toprow, &botrow );
	fb_ConsoleGetXY( &col, &row );

#ifdef DISABLE_NCURSES
	printf( "%s", buffer );
#else

	/* scrolling */
	if( (row > botrow) && (botrow != fb_ConsoleGetMaxRow( )) )
	{
		row = botrow + 1;
		fb_ConsoleLocate(row, col, -1);
	}

	rowstoscroll = 0;
	if (mask & FB_PRINT_NEWLINE) {
		buffer[len - 1] = '\0';
		len--;
		rowstoscroll++;
	}
	if (col + len - 1 > cols)
		rowstoscroll += 1 + ((len - (cols - col + 1)) / cols);
	if (row + rowstoscroll > fb_ConsoleGetMaxRow()) {
		fb_ConsoleScroll((row + rowstoscroll) - fb_ConsoleGetMaxRow());
		fb_ConsoleLocate(fb_ConsoleGetMaxRow() - rowstoscroll, col, -1);
	}
	else {
		rowsleft = botrow - (row - 1);
		if (rowstoscroll > rowsleft) {
			fb_ConsoleScroll(rowstoscroll - rowsleft);
			fb_ConsoleLocate(botrow - rowstoscroll + 1, col, -1);
		}
	}
	printw("%s", buffer);
	if (mask & FB_PRINT_NEWLINE)
		move(getcury(stdscr) + 1, 0);
	refresh();
#endif

}

