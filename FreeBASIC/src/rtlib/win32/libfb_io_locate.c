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
 * io_locate.c -- locate (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

/*:::::*/
void fb_ConsoleLocate( int row, int col, int cursor )
{
	HANDLE handle;
	COORD c;
	CONSOLE_CURSOR_INFO info;

  	if( col > 0 )
  		c.X = col - 1;
  	else
  		c.X = fb_ConsoleGetX() - 1;

  	if( row > 0 )
  		c.Y = row - 1;
  	else
  		c.Y = fb_ConsoleGetY() - 1;

  	handle = GetStdHandle( STD_OUTPUT_HANDLE );
  	if( cursor >= 0 ) {
  		GetConsoleCursorInfo( handle, &info );
  		info.bVisible = ( cursor ? TRUE : FALSE );
  		SetConsoleCursorInfo( handle, &info );
  	}

  	SetConsoleCursorPosition( handle, c );

}


/*:::::*/
int fb_ConsoleGetX( void )
{
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );
    return info.dwCursorPosition.X + 1;

}

/*:::::*/
int fb_ConsoleGetY( void )
{
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );
    return info.dwCursorPosition.Y + 1;

}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
    CONSOLE_SCREEN_BUFFER_INFO info;

    GetConsoleScreenBufferInfo( GetStdHandle( STD_OUTPUT_HANDLE ), &info );

    if( col != NULL )
    	*col = info.dwCursorPosition.X + 1;
    if( row != NULL )
    	*row = info.dwCursorPosition.Y + 1;
}

/*:::::*/
FBCALL int fb_ConsoleReadXY( int col, int row, int colorflag )
{
    TCHAR character;
    WORD attribute;
    DWORD res;
    COORD coord;
    
    coord.X = col - 1;
    coord.Y = row - 1;
    
    if( colorflag ) {
        ReadConsoleOutputAttribute( GetStdHandle( STD_OUTPUT_HANDLE ), &attribute, 1, coord, &res);
        return attribute;
    }
    else {
    	ReadConsoleOutputCharacter( GetStdHandle( STD_OUTPUT_HANDLE ), &character, 1, coord, &res);
    	return character;
    }
}
