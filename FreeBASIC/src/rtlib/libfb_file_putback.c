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
 *	file_putback - some kind of ungetc function
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_FilePutBackEx( FB_FILE *handle, const void *data, size_t length )
{
    int res;

    if( handle==NULL )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    if( length + handle->putback_size > sizeof(handle->putback_buffer) ) {
        res = fb_ErrorSetNum( FB_RTERROR_FILEIO );
    } else {
        if( handle->putback_size ) {
            memmove( handle->putback_buffer + length,
                     handle->putback_buffer,
                     handle->putback_size );
        }
        memcpy( handle->putback_buffer,
                data,
                length );
        handle->putback_size += length;
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_FilePutBack( int fnum, const void *data, size_t length)
{
    return fb_FilePutBackEx( FB_FILE_TO_HANDLE(fnum), data, length );
}

