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
 * io_cls.c -- cls (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb.h"
#include <stdio.h>

#ifndef DISABLE_NCURSES
#include <curses.h>
#endif


/*:::::*/
void fb_ConsoleClear( int mode )
{
    int start_line, end_line, toprow, botrow, i;

#ifndef DISABLE_NCURSES
    fb_ConsoleGetView( &toprow, &botrow );

	if( (mode == 1) || (mode == 0xFFFF0000) )	/* same as gfxlib's DEFAULT_COLOR */
	{
		start_line = toprow - 1;
		end_line = botrow - 1;
    }
    else
    {
    	start_line = 0;
    	end_line = getmaxy(stdscr) - 1;
    }
    for (; start_line <= end_line; start_line++) {
    	move(start_line, 0);
    	for (i = getmaxx(stdscr); i; i--)
    	    addch(' ');
    }
    refresh();
#endif

    fb_ConsoleLocate( toprow, 1, -1 );

}


