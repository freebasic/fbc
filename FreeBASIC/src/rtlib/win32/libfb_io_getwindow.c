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
 * io_getwindow.c -- size of the console window
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include "fb.h"

/*:::::*/
void fb_ConsoleGetWindow( int *left, int *top, int *cols, int *rows )
{
   	CONSOLE_SCREEN_BUFFER_INFO info;
    GetConsoleScreenBufferInfo( fb_out_handle, &info );

    if( left != NULL )
        *left = info.srWindow.Left + 1;
    if( top != NULL )
        *top = info.srWindow.Top + 1;

    if( cols != NULL )
        *cols = info.srWindow.Right - info.srWindow.Left + 1;
    if( rows != NULL )
        *rows = info.srWindow.Bottom - info.srWindow.Top + 1;
}

/*:::::*/
void fb_ConsoleGetMaxWindowSize( int *cols, int *rows )
{
   	COORD max = GetLargestConsoleWindowSize( fb_out_handle );
    if( cols != NULL )
        *cols = max.X;
    if( rows != NULL )
        *rows = max.Y;
}
