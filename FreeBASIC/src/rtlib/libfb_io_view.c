/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * io_view.c -- view print (console, no gfx)
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
int fb_ConsoleViewEx( int toprow, int botrow, int set_cursor )
{
    int do_update = FALSE;
    int maxrow, minrow;


    minrow = 1;
    fb_GetSize( NULL, &maxrow );
    if( maxrow==0 )
        maxrow = FB_SCRN_DEFAULT_HEIGHT;

    if( toprow > 0 ) {
        do_update = TRUE;
    } else if ( toprow == 0 ) {
        do_update = TRUE;
        toprow = minrow;
    } else {
        toprow = fb_ConsoleGetTopRow() + 1;
    }

    if( botrow > 0 ) {
        do_update = TRUE;
    } else if ( botrow == 0 ) {
        do_update = TRUE;
        botrow = maxrow;
    } else {
        botrow = fb_ConsoleGetBotRow() + 1;
    }

    if( toprow > botrow
        || toprow < 1
        || botrow < 1
        || toprow > maxrow
        || botrow > maxrow )
    {
        /* This is an error ... */
        do_update = FALSE;
        botrow = toprow = 0;
    }

    if( do_update ) {
        fb_ConsoleSetTopBotRows( toprow - 1, botrow - 1 );
        fb_ViewUpdate( );
        if( set_cursor ) {
            /* set cursor to top row */
            fb_Locate( toprow, 1, -1, 0, 0 );
        }
    }

    return toprow + (botrow << 16);
}

/*:::::*/
FBCALL int fb_ConsoleView( int toprow, int botrow )
{
    return fb_ConsoleViewEx( toprow, botrow, TRUE );
}

