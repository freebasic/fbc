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
 *	file_print - print # function (formating is done at io_prn)
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_hFilePrintBufferEx( FB_FILE *handle, const void *buffer, size_t len )
{
    int res;
    size_t i;
    const char *pachText = (const char *) buffer;

    if( handle==NULL )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_FilePutDataEx( handle, 0, buffer, len, TRUE );

#ifndef FB_NATIVE_TAB
    if ( res == FB_RTERROR_OK ) {
        /* search for last printed CR or LF */
        i=len;
        while (i--) {
            char ch = pachText[i];
            if (ch=='\n' || ch=='\r') {
                break;
            }
        }
        ++i;
        handle = FB_HANDLE_DEREF(handle);
        if (i==0) {
            handle->line_length += len;
        } else {
            handle->line_length = len - i;
        }
        {
            int iWidth = FB_HANDLE_DEREF(handle)->width;
            if( iWidth!=0 ) {
                handle->line_length %= iWidth;
            }
        }
    }
#endif

    FB_UNLOCK();

    return res;
}

/*:::::*/
int fb_hFilePrintBuffer( int fnum, const char *buffer )
{
    return fb_hFilePrintBufferEx( FB_FILE_TO_HANDLE(fnum),
                                  buffer, strlen( buffer ) );
}
