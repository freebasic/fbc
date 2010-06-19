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
 * io_spc.c -- spc and tab functions
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintTab( int fnum, int newcol )
{
    FB_FILE *handle;
    int col, row, cols, rows;

    fb_DevScrnInit_NoOpen( );

    FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);

	if( FB_HANDLE_IS_SCREEN(handle) || handle->type == FB_FILE_TYPE_CONSOLE )
    {
        if( handle->type == FB_FILE_TYPE_CONSOLE ) {
            if( handle->hooks && handle->hooks->pfnFlush )
                handle->hooks->pfnFlush( handle );
        }

        /* Ensure that we get the "real" cursor position - this quirk is
         * required for cursor positions at the right bottom of the screen */
        fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
		fb_GetXY( &col, &row );
		fb_GetSize( &cols, &rows );

    	if( newcol > cols )
    		newcol %= cols;

        if( col > newcol ) {
            fb_PrintVoidEx ( handle, FB_PRINT_NEWLINE );
			fb_Locate( 0, newcol, -1, 0, 0 );

        } else if( newcol < 1 )
    		fb_Locate( 0, 1, -1, 0, 0 );

    	else
            fb_Locate( 0, newcol, -1, 0, 0 );

    } else {

        if( handle->type==FB_FILE_TYPE_PIPE ) {

            fb_PrintPadEx ( handle, 0 );

        } else {

            if( newcol > handle->line_length ) {
                fb_PrintStringEx( handle,
                                  fb_StrFill1( newcol - handle->line_length - 1, ' ' ),
                                  0 );
            } else {

                if( handle->mode==FB_FILE_MODE_BINARY ) {
                    fb_PrintStringEx( handle,
                                      fb_StrAllocTempDescF( FB_BINARY_NEWLINE, sizeof( FB_BINARY_NEWLINE ) ),
                                      0 );
                } else {
                    fb_PrintStringEx( handle,
                                      fb_StrAllocTempDescF( FB_NEWLINE, sizeof( FB_NEWLINE ) ),
                                      0 );
                }

                if( newcol > 0 ) {
                    fb_PrintStringEx( handle,
                                      fb_StrFill1( newcol - 1, ' ' ),
                                      0 );
                }

            }

        }

    }

    FB_UNLOCK();
}


/*:::::*/
FBCALL void fb_PrintSPC( int fnum, int n )
{
    FB_FILE *handle;
    int col, row, cols, rows, newcol;

    if( n==0 )
        return;

    fb_DevScrnInit_NoOpen( );

    FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);

	if( FB_HANDLE_IS_SCREEN(handle) || handle->type == FB_FILE_TYPE_CONSOLE )
	{
		if( n == 0 )
			return;

        if( handle->type == FB_FILE_TYPE_CONSOLE ) {
            if( handle->hooks && handle->hooks->pfnFlush )
                handle->hooks->pfnFlush( handle );
        }

        /* Ensure that we get the "real" cursor position - this quirk is
         * required for cursor positions at the right bottom of the screen */
        fb_PrintBufferEx( NULL, 0, FB_PRINT_FORCE_ADJUST );
		fb_GetXY( &col, &row );
		fb_GetSize( &cols, &rows );

    	newcol = col + n;
        if( newcol > cols ) {
            fb_PrintVoidEx ( handle, FB_PRINT_NEWLINE );
            newcol %= cols;
        }

        fb_Locate( 0, newcol, -1, 0, 0 );

    } else {

        fb_PrintStringEx( handle, fb_StrFill1( n, ' ' ), 0 );

    }

    FB_UNLOCK();
}

