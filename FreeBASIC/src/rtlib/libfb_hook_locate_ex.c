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
 * hook_locate_ex.c -- locate entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_LocateEx( int row, int col, int cursor, int *current_pos )
{
    int tmp_current_pos = 0;
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    int start_y, end_y, con_width;

    fb_ConsoleGetView(&start_y, &end_y);
    fb_GetSize( &con_width, NULL );

    if( row!=0 && (row<start_y || row>end_y) ) {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    } else if( col!=0 && (col<1 || col>con_width) ) {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    } else {
        fb_DevScrnInit_NoOpen( );

        FB_LOCK();

        if( __fb_ctx.hooks.locateproc ) {
            tmp_current_pos = __fb_ctx.hooks.locateproc( row, col, cursor );
        } else {
            tmp_current_pos = fb_ConsoleLocate( row, col, cursor );
        }

        if( col!=0 )
            FB_HANDLE_SCREEN->line_length = col - 1;

        FB_UNLOCK();
    }

    if( current_pos )
        *current_pos = tmp_current_pos;

	return res;
}
