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
 * hook_locate.c -- locate entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_Locate( int row, int col, int cursor )
{
    int res, start_y, end_y;

    fb_ConsoleGetView(&start_y, &end_y);
    if( row>0 && (row<start_y || row>end_y) ) {
        /* It's not allowed to change the cursor position if the new position
         * is invalid! */
        row = col = 0;
    }

    fb_DevScrnInit_NoOpen( );

    FB_LOCK();

    if( fb_hooks.locateproc ) {
		res = fb_hooks.locateproc( row, col, cursor );
    } else {
        res = fb_ConsoleLocate( row, col, cursor );
    }

    if( col > 0 )
        FB_HANDLE_SCREEN->line_length = col - 1;

    FB_UNLOCK();

	return res;
}
