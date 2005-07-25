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
 *	file_put - put # function
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_FilePutDataEx( FB_FILE *handle, long pos, const void *data, size_t length, int adjust_rec_pos)
{
	int res;

    if( handle==NULL )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    /* clear put back buffer for every modifying non-read operation */
    handle->putback_size = 0;

    /* seek to newpos */
    if( pos > 0 ) {
        res = fb_FileSeekEx( handle, pos );
    }

    if (res==FB_RTERROR_OK) {
        /* do write */
        if( handle->hooks != NULL ) {
            if( handle->hooks->pfnWrite != NULL ) {
                res = handle->hooks->pfnWrite( handle, data, length );
            } else {
                res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
            }
        } else if( handle->f != NULL ) {
            if( fwrite( data, 1, length, handle->f ) != length ) {
                res = fb_ErrorSetNum( FB_RTERROR_FILEIO );
            }
        } else {
            /* file not open yet? */
            res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    if (res==FB_RTERROR_OK && adjust_rec_pos) {
        /* if in random mode, writes must be of reclen */
        if( handle->mode == FB_FILE_MODE_RANDOM )
        {
            length %= handle->len;
            length = handle->len - length;
            if (length != 0) {
                if( handle->hooks != NULL) {
                    /* we use a write here because a seek might be unsupported
                     * for the given device */
                    int copylen;
                    char achBuffer[512];
                    memset(achBuffer, 0,
                           ((length > sizeof(achBuffer)) ? sizeof(achBuffer) : length));
                    for (;
                         length != 0;
                         length -= copylen)
                    {
                        copylen = (length < sizeof(achBuffer)) ? length : sizeof(achBuffer);
                        res = handle->hooks->pfnWrite( handle, achBuffer, copylen );
                        if( res!=0 )
                            break;
                    }
                } else {
                    /* otherwise, we'll simply seek to the next position */
                    fseek( handle->f, length, SEEK_CUR );
                }
            }
        }
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
int fb_FilePutData( int fnum, long pos, const void *data, size_t length, int adjust_rec_pos)
{
    return fb_FilePutDataEx( FB_FILE_TO_HANDLE(fnum), pos, data, length, adjust_rec_pos );
}

/*:::::*/
FBCALL int fb_FilePut( int fnum, long pos, void* value, unsigned int valuelen )
{
	return fb_FilePutData( fnum, pos, value, valuelen, TRUE );
}
