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
 * io_getxy.c -- GetXY function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *       jul/2005 mod: use convert*console functions [mjs]
 *
 */

#include "fb.h"

/*:::::*/
void fb_ConsoleGetRawXYEx( HANDLE hConsole, int *col, int *row )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( hConsole, &info ) == 0 ) {
        if( col != NULL )
            *col = -1;
        if( row != NULL )
            *row = -1;
    } else {
        if( col != NULL )
            *col = info.dwCursorPosition.X;
        if( row != NULL )
            *row = info.dwCursorPosition.Y;
    }
}

/*:::::*/
void fb_ConsoleGetRawXY( int *col, int *row )
{
    fb_ConsoleGetRawXYEx( fb_out_handle, col, row );
}

/*:::::*/
FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
    CONSOLE_SCREEN_BUFFER_INFO info;
    if( GetConsoleScreenBufferInfo( fb_out_handle, &info ) == 0 ) {
        if( col != NULL )
            *col = 0;
        if( row != NULL )
            *row = 0;
    } else {
        if( col != NULL )
            *col = info.dwCursorPosition.X;
        if( row != NULL )
            *row = info.dwCursorPosition.Y;
        fb_hConvertFromConsole( col, row, NULL, NULL );
    }
}

