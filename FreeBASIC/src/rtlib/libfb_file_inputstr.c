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
 * file_inputstr - input$ function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"


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
		return &__fb_ctx.null_desc;
	}

    dst = fb_hStrAllocTemp( NULL, bytes );
    if( dst!=NULL )
    {
        size_t read_count = 0;
        if( FB_HANDLE_IS_SCREEN(handle) )
        {
            dst->data[0] = 0;
            while( read_count!=bytes ) {
                res = fb_FileGetDataEx( handle,
                                        0,
                                        dst->data + read_count,
                                        bytes - read_count,
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
            res = fb_FileGetDataEx( handle,
                                    0,
                                    dst->data,
									bytes,
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

        dst = &__fb_ctx.null_desc;
    }

    FB_UNLOCK();

    return dst;
}

