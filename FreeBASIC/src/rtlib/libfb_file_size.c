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
 *	file_size - file size
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
unsigned int fb_FileSizeEx( FB_FILE *handle )
{
	long res = 0;

    if( !FB_HANDLE_USED(handle) )
		return res;

	FB_LOCK();

    if (handle->hooks->pfnSeek!=NULL && handle->hooks->pfnTell!=NULL) {
        long old_pos;
        /* remember old position */
        int result = handle->hooks->pfnTell(handle, &old_pos);
        if (result==0) {
            /* move to end of file */
            result = handle->hooks->pfnSeek(handle, 0, SEEK_END);
        }
        if (result==0) {
            /* get size */
            result = handle->hooks->pfnTell(handle, &res);
            /* restore old position*/
            handle->hooks->pfnSeek(handle, old_pos, SEEK_SET);
        }
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL unsigned int fb_FileSize( int fnum )
{
    return fb_FileSizeEx(FB_FILE_TO_HANDLE(fnum));
}
