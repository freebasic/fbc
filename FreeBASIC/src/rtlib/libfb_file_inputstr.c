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
 * file_inputstr - input$ function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"


/*:::::*/
FBCALL FBSTRING *fb_FileStrInput( int bytes, int fnum )
{
    FB_FILE   *handle;
	FBSTRING  *dst;
    size_t 	   len;
    int        res = FB_RTERROR_OK;

	FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
	if( handle==NULL || (handle->f == NULL && handle->hooks==NULL) ) {
		FB_UNLOCK();
		return &fb_strNullDesc;
	}

	FB_STRLOCK();

	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
    if( dst != NULL ) {
        /* resize the string */
        fb_hStrAllocTemp( dst, bytes );
        if( dst->data != NULL )
        {
            size_t read_count = 0;
            if( FB_HANDLE_IS_SCREEN(handle) ) {
                while( read_count!=bytes ) {
                    len = bytes - read_count;
                    res = fb_FileGetDataEx( handle,
                                            0,
                                            dst->data + read_count,
                                            &len, TRUE );
                    if( res!=FB_RTERROR_OK ) {
                        break;
                    }
                    read_count += len;
                }
            } else {
                len = bytes;
                res = fb_FileGetDataEx( handle,
                                        0,
                                        dst->data,
                                        &len, TRUE );
                if( res==FB_RTERROR_OK ) {
                    read_count += len;
                }
            }
            if( read_count != bytes )
            {
                dst->data[read_count] = '\0';
                dst->len = read_count | FB_TEMPSTRBIT;   /* mark as temp */
            }
        } else {
            res = FB_RTERROR_OUTOFMEM;
        }
    } else {
        res = FB_RTERROR_OUTOFMEM;
    }

    if( res != FB_RTERROR_OK ) {
        if( dst != NULL ) {
            fb_hStrDelTempDesc( dst );
        }

        dst = &fb_strNullDesc;
    }

    FB_STRUNLOCK();
    FB_UNLOCK();

    return dst;
}

