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
 * io_cls.c -- cls (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include <assert.h>
#include "fb.h"


/*:::::*/
void fb_ConsoleClearViewRawEx( HANDLE hConsole, int x1, int y1, int x2, int y2 )
{
    WORD    attr = (WORD) fb_ConsoleGetColorAttEx( hConsole );
    int     width = x2 - x1 + 1, lines = y2 - y1 + 1;

    if( width==0 || lines==0 )
        return;

    assert(width > 0);
    assert(lines > 0);

    while (lines--) {
        DWORD written;
        COORD coord = { x1, y1 + lines };
        FillConsoleOutputAttribute( hConsole, attr, width, coord, &written);
        FillConsoleOutputCharacter( hConsole, ' ', width, coord, &written );
    }

    fb_ConsoleLocateRawEx( hConsole, y1, x1, -1 );
}

/*:::::*/
void fb_ConsoleClear( int mode )
{
    /* This is the view in screen buffer coordinates (0-based) */
    int		view_left, view_top, view_right, view_bottom;

    /* This is the window in screen buffer coordinates (0-based) */
    int     win_left, win_top, win_right, win_bottom;

    if( FB_CONSOLE_WINDOW_EMPTY() )
        return;

    win_top = srConsoleWindow.Top;
    win_left = srConsoleWindow.Left;
    win_right = srConsoleWindow.Right;
    win_bottom = srConsoleWindow.Bottom;

	if( (mode == 1) || (mode == 0xFFFF0000) )	/* same as gfxlib's DEFAULT_COLOR */
    {
        /* Just fill the view */
        fb_ConsoleGetView( &view_top, &view_bottom );

        /* Translate the rows of the view to screen buffer coordinates (0-based) */
        fb_hConvertToConsole( NULL, &view_top, NULL, &view_bottom );
        view_left = win_left;
        view_right = win_right;

    } else {
        /* Fill the whole window? */
        view_top = win_top;
        view_left = win_left;
        view_right = win_right;
        view_bottom = win_bottom;
    }

    assert(view_left <= view_right);
    assert(view_top <= view_bottom);

    fb_ConsoleClearViewRawEx( fb_out_handle, view_left, view_top, view_right, view_bottom );
}
