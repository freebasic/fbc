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
void fb_ConsoleClear( int mode )
{
   	CONSOLE_SCREEN_BUFFER_INFO info;
    int     width, lines;

    /* This is the view in screen buffer coordinates (1-based) */
    int		view_left, view_top, view_right, view_bottom;

    /* This is the window in screen buffer coordinates (1-based) */
    int     win_left, win_top, win_right, win_bottom;

    GetConsoleScreenBufferInfo( fb_out_handle, &info );

    fb_ConsoleGetWindow( &win_left, &win_top, &win_right, &win_bottom );
    win_right += win_left - 1;
    win_bottom += win_top - 1;

	if( (mode == 1) || (mode == 0xFFFF0000) )	/* same as gfxlib's DEFAULT_COLOR */
    {
        /* Just fill the view */

        fb_ConsoleGetView( &view_top, &view_bottom );

        /* Translate the rows of the view to screen buffer coordinates (1-based) */
#if FB_CON_BOUNDS==1 || FB_CON_BOUNDS==2
        view_top += win_top - 1;
        view_bottom += win_top - 1;
#endif

#if FB_CON_BOUNDS==1
        view_left = win_left;
        view_right = win_right;
#else
        view_left = 1;
        view_right = info.dwSize.X;
#endif

    } else {
        /* Fill the whole window? */
        view_top = win_top;
        view_left = win_left;
        view_right = win_right;
        view_bottom = win_bottom;
    }

    assert(view_left <= view_right);
    assert(view_top <= view_bottom);

    width = view_right - view_left + 1;
    lines = view_bottom - view_top + 1;

    while (lines--) {
        DWORD written;
        COORD coord = { view_left - 1, view_top + lines - 1 };
        FillConsoleOutputAttribute( fb_out_handle, info.wAttributes, width, coord, &written);
        FillConsoleOutputCharacter( fb_out_handle, ' ', width, coord, &written );
    }

    fb_ConsoleLocate( view_top - win_top + 1, 1, -1 );
}
