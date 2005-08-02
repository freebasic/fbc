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
 * io_locate.c -- locate (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *       jul/2005 mod: use convert*console functions [mjs]
 *                mod: fixed return and default values [mjs]
 *
 */

#include "fb.h"

int fb_ConsoleGetRawX( void );
int fb_ConsoleGetRawY( void );

/*:::::*/
void fb_ConsoleLocateRawEx( HANDLE hConsole, int row, int col, int cursor )
{
	COORD c;

    if( col < 0 )
        col = fb_ConsoleGetRawXEx( hConsole );
    if( row < 0 )
        row = fb_ConsoleGetRawYEx( hConsole );

    c.X = (SHORT) col;
    c.Y = (SHORT) row;

  	if( cursor >= 0 ) {
        CONSOLE_CURSOR_INFO info;
        GetConsoleCursorInfo( fb_out_handle, &info );
  		info.bVisible = ( cursor ? TRUE : FALSE );
  		SetConsoleCursorInfo( hConsole, &info );
  	}

  	SetConsoleCursorPosition( hConsole, c );
}

/*:::::*/
FBCALL void fb_ConsoleLocateRaw( int row, int col, int cursor )
{
	fb_ConsoleLocateRawEx( fb_out_handle, row, col, cursor );
}


