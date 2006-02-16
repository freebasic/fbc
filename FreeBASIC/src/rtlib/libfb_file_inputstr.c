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

	fb_DevScrnInit_Read( );

	FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
    if( !FB_HANDLE_USED(handle) )
    {
		FB_UNLOCK();
		return &fb_strNullDesc;
	}

    dst = fb_hStrAllocTemp( NULL, bytes );
    if( dst!=NULL )
    {
        size_t read_count = 0;
        if( FB_HANDLE_IS_SCREEN(handle) )
        {
            dst->data[0] = 0;
            while( read_count!=bytes ) {
                len = bytes - read_count;
                res = fb_FileGetDataEx( handle,
                                        0,
                                        dst->data + read_count,
                                        &len,
                                        TRUE,
                                        FALSE );
                if( res!=FB_RTERROR_OK ) {
                    break;
                }
                read_count += len;

                /* add the null-term */
                dst->data[read_count] = '\0';
            }
        }
        else
        {
            len = bytes;
            res = fb_FileGetDataEx( handle,
                                    0,
                                    dst->data,
                                    &len,
                                    TRUE,
                                    FALSE );
            if( res==FB_RTERROR_OK ) {
                read_count += len;
            }
        }

        /* add the null-term */
        dst->data[read_count] = '\0';

        if( read_count != bytes )
        {
            fb_hStrSetLength( dst, read_count );
        }
    }
    else
    {
        res = FB_RTERROR_OUTOFMEM;
    }

    if( res != FB_RTERROR_OK )
    {
        if( dst != NULL )
            fb_hStrDelTemp( dst );

        dst = &fb_strNullDesc;
    }

    FB_UNLOCK();

    return dst;
}

