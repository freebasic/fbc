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
 * io_cls.c -- cls (console, no gfx) function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include <stdio.h>

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#else
#ifndef DISABLE_NCURSES
#include <curses.h>
#endif
#endif


/*:::::*/
void fb_ConsoleClear( int mode )
{

#ifdef WIN32
    HANDLE 	hnd;
    DWORD 	written;
    CONSOLE_SCREEN_BUFFER_INFO info;
    int		chars, toprow, botrow;
    COORD	startcoord;

    hnd = GetStdHandle( STD_OUTPUT_HANDLE );

    GetConsoleScreenBufferInfo( hnd, &info );

    fb_ConsoleGetView( &toprow, &botrow );

	if( (mode == 1) || (mode == 0xFFFF0000) )	/* same as gfxlib's DEFAULT_COLOR */
	{
    	startcoord.X = 0;
    	startcoord.Y = toprow - 1;

	    chars = info.dwSize.X * (botrow - toprow + 1);

    }
    else
    {
    	startcoord.X = 0;
    	startcoord.Y = 0;

    	chars = info.dwSize.X * info.dwSize.Y;
    }


    FillConsoleOutputAttribute( hnd, info.wAttributes, chars, startcoord, &written);

    FillConsoleOutputCharacter( hnd, ' ', chars, startcoord, &written );

#else /* WIN32 */

    int start_line, end_line, toprow, botrow;
    
#ifndef DISABLE_NCURSES
    fb_ConsoleGetView( &toprow, &botrow );

	if( mode == 1 )
	{
		start_line = toprow - 1;
		end_line = botrow - 1;
    }
    else
    {
    	start_line = 0;
    	end_line = getmaxy(stdscr);
    }
    for (; start_line <= end_line; start_line++) {
    	move(start_line, 0);
    	clrtoeol();
    }
    refresh();
#endif

#endif /* WIN32 */


    fb_ConsoleLocate( toprow, 1 );

}

/*:::::*/
FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
    int toprow, botrow;

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    if( cols != NULL )
    {
    	if( !GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info ) )
    		*cols = 80;
    	else
    		*cols = info.dwSize.X;
    }

#else /* WIN32 */

#ifndef DISABLE_NCURSES
	if (cols != NULL)
		*cols = getmaxx(stdscr) + 1;
#endif

#endif /* WIN32 */

    if( rows != NULL )
    {
    	fb_ConsoleGetView( &toprow, &botrow );

    	*rows = botrow - toprow + 1;
    }
}
