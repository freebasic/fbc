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
 * io_locate.c -- locate (console, no gfx) function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

#ifdef WIN32
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#endif

/*:::::*/
void fb_ConsoleLocate( int row, int col )
{

#ifdef WIN32
	COORD c;

  	if( col > 0 )
  		c.X = col - 1;
  	else
  		c.X = fb_ConsoleGetX() - 1;

  	if( row > 0 )
  		c.Y = row - 1;
  	else
  		c.Y = fb_ConsoleGetY() - 1;

  	SetConsoleCursorPosition( GetStdHandle( STD_OUTPUT_HANDLE ), c );

#else /* WIN32 */

	!!!WRITEME!!! use gnu curses here !!!WRITEME!!!

#endif /* WIN32 */

}


/*:::::*/
int fb_ConsoleGetX( void )
{

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );
    return info.dwCursorPosition.X + 1;

#else /* WIN32 */

	!!!WRITEME!!! use gnu curses here !!!WRITEME!!!

#endif /* WIN32 */

}

/*:::::*/
int fb_ConsoleGetY( void )
{

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );
    return info.dwCursorPosition.Y + 1;

#else /* WIN32 */

	!!!WRITEME!!! use gnu curses here !!!WRITEME!!!

#endif /* WIN32 */

}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{

#ifdef WIN32
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );

    if( col != NULL )
    	*col = info.dwCursorPosition.X + 1;
    if( row != NULL )
    	*row = info.dwCursorPosition.Y + 1;

#else /* WIN32 */

	!!!WRITEME!!! use gnu curses here !!!WRITEME!!!

#endif /* WIN32 */

}

