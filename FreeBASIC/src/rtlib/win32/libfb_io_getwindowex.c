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
 * io_getwindowex.c -- size of the console window
 *
 * chng: jul/2005 written [mjs]
 *       jul/2005 mod: added convert*console functions [mjs]
 *
 */

#include <stdlib.h>
#include "fb.h"

void fb_InitConsoleWindow( void );

/*:::::*/
void fb_hConsoleGetWindow( int *left, int *top, int *cols, int *rows )
{
    fb_InitConsoleWindow( );

    if( FB_CONSOLE_WINDOW_EMPTY() )
    {
        if( left != NULL )
            *left = 0;
        if( top != NULL )
            *top = 0;
        if( cols != NULL )
            *cols = 0;
        if( rows != NULL )
            *rows = 0;
    }
    else
    {
        if( left != NULL )
            *left = srConsoleWindow.Left;
        if( top != NULL )
            *top = srConsoleWindow.Top;
        if( cols != NULL )
            *cols = srConsoleWindow.Right - srConsoleWindow.Left + 1;
        if( rows != NULL )
            *rows = srConsoleWindow.Bottom - srConsoleWindow.Top + 1;
    }
}


