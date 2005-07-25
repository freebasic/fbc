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
 *	file_get - get # function
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"


/*:::::*/
int fb_FileGetDataEx( FB_FILE *handle, long pos, void* value, size_t *pLength, int adjust_rec_pos )
{
    size_t res;
    size_t length, read_count = 0;
    char *pachData = (char*) value;

    assert(pLength!=NULL);

    if( handle==NULL )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    length = *pLength;

    /* seek to newpos */
    if( pos > 0 ) {
        res = fb_FileSeekEx( handle, pos );
    }

    if( handle->putback_size != 0 ) {
        size_t copy_size = (handle->putback_size > length) ? handle->putback_size : length;
        memcpy( pachData, handle->putback_buffer, copy_size );
        handle->putback_size -= copy_size;
        read_count = copy_size;
        length -= copy_size;
        pachData += copy_size;
        if( handle->putback_size != 0 ) {
            memmove( handle->putback_buffer,
                     handle->putback_buffer + copy_size,
                     handle->putback_size );
        }
    }

    if ( (res==FB_RTERROR_OK) && (length != 0) ) {
        /* do read */
        if (handle->hooks != NULL) {
            if( handle->hooks->pfnRead!=NULL ) {
                size_t rlen = length;
                res = handle->hooks->pfnRead( handle, pachData, &rlen );
                read_count += rlen;
            } else {
                res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            }

        } else if( handle->f != NULL ) {
            size_t rlen = fread( pachData, 1, length, handle->f );
            if( rlen != length ) {
                /* fill with nulls if at eof */
                memset(pachData + rlen, 0, length - rlen );
            }
            read_count += rlen;
        } else {
            /* unused file handle */
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if( res==FB_RTERROR_OK ) {
        *pLength = read_count;
    }

    if (res==FB_RTERROR_OK && adjust_rec_pos) {
        /* if in random mode, reads must be of reclen */
        if( handle->mode == FB_FILE_MODE_RANDOM )
        {
            size_t skip_size = handle->len - (length + read_count) % handle->len;
            if( skip_size != 0 ) {
                /* don't forget the put back buffer */
                if( skip_size > handle->putback_size ) {
                    skip_size -= handle->putback_size;
                    handle->putback_size = 0;
                } else {
                    handle->putback_size -= skip_size;
                    skip_size = 0;
                }
            }
            if (skip_size!=0) {
                if (handle->hooks != NULL) {
                    /* we use a read here because a seek might be unsupported
                     * for the given device */
                    size_t copylen;
                    char achBuffer[512];
                    for (;
                         skip_size != 0;
                         skip_size -= copylen)
                    {
                        copylen = (length < sizeof(achBuffer)) ? skip_size : sizeof(achBuffer);
                        res = handle->hooks->pfnRead( handle, achBuffer, &copylen );
                        if( res!=0 )
                            break;
                    }
                } else {
                    /* otherwise, we'll simply seek to the next position */
                    fseek( handle->f, skip_size, SEEK_CUR );
                }
            }
        }
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
int fb_FileGetData( int fnum, long pos, void* value, size_t length, int adjust_rec_pos )
{
    return fb_FileGetDataEx(FB_FILE_TO_HANDLE(fnum), pos, value, &length, adjust_rec_pos);
}

/*:::::*/
FBCALL int fb_FileGet( int fnum, long pos, void* value, unsigned int valuelen )
{
	return fb_FileGetData( fnum, pos, value, valuelen, TRUE );
}
