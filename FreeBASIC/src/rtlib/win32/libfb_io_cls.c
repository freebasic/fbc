/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * io_cls.c -- cls (console, no gfx) function for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include "fb.h"

void fb_InitConsoleWindow( void );

/*:::::*/
void fb_ConsoleClear( int mode )
{
    /* This is the view in screen buffer coordinates (0-based) */
    int		view_left, view_top, view_right, view_bottom;

    /* This is the window in screen buffer coordinates (0-based) */
    int     win_left, win_top, win_right, win_bottom;

    fb_InitConsoleWindow();

    if( FB_CONSOLE_WINDOW_EMPTY() || mode==1 )
        return;

    win_top = __fb_con.window.Top;
    win_left = __fb_con.window.Left;
    win_right = __fb_con.window.Right;
    win_bottom = __fb_con.window.Bottom;

	if( (mode == 2) || (mode == 0xFFFF0000) )	/* same as gfxlib's DEFAULT_COLOR */
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

    DBG_ASSERT(view_left <= view_right);
    DBG_ASSERT(view_top <= view_bottom);

    fb_ConsoleClearViewRawEx( __fb_out_handle, view_left, view_top, view_right, view_bottom );
}
