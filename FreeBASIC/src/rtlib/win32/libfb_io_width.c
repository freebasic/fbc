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
 * io_width.c -- width (console, no gfx) for Windows
 *
 * credits: code based on PDCurses, Win32 port by Chris Szurgot (szurgot@itribe.net)
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

void fb_InitConsoleWindow( void );

/*:::::*/
int fb_ConsoleWidth( int cols, int rows )
{
   	COORD size, max;
    int cur, do_change = FALSE;
    int ncols, nrows;

    fb_InitConsoleWindow( );

    if( FB_CONSOLE_WINDOW_EMPTY() )
        return 0;

   	max = GetLargestConsoleWindowSize( fb_out_handle );
    fb_hConsoleGetWindow( NULL, NULL, &ncols, &nrows );

    if( cols > 0 )
    {
        size.X = cols;
        do_change = TRUE;
    }
    else
    {
        size.X = (SHORT) ncols;
    }

    if( rows > 0 )
    {
        size.Y = rows;
        do_change = TRUE;
    }
    else
    {
        size.Y = (SHORT) nrows;
    }

    cur = size.X | (size.Y << 16);

    if( do_change ) {
        SMALL_RECT rect;
        rect.Left = rect.Top = 0;
        rect.Right = size.X - 1;
        if( rect.Right > max.X )
            rect.Right = max.X;

        rect.Bottom = rect.Top + size.Y - 1;
        if( rect.Bottom > max.Y )
            rect.Bottom = max.Y;

        /* reset view */
        fb_ConsoleSetTopBotRows( rect.Top, rect.Bottom );

        /* Execute this twice to handle the case where the
         * screen buffer gets smaller than the window */
        SetConsoleScreenBufferSize( fb_out_handle, size );
        SetConsoleWindowInfo( fb_out_handle, TRUE, &rect );
        SetConsoleScreenBufferSize( fb_out_handle, size );
        SetConsoleWindowInfo( fb_out_handle, TRUE, &rect );
    }

    SetConsoleActiveScreenBuffer( fb_out_handle );

    if( do_change ) {
        /* Re-enable updating */
        ConsoleSetByUser = FALSE;

        fb_hUpdateConsoleWindow( );

        ConsoleSetByUser = TRUE;
    }

	return cur;
}
