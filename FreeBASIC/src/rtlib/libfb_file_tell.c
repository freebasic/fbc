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
 *	file_seek - seek function and stmt
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"


/*:::::*/
long fb_FileTellEx( FB_FILE *handle )
{
	long pos;

    if( !FB_HANDLE_USED(handle) )
		return 0;

	FB_LOCK();

    if (handle->hooks->pfnTell != NULL) {
        if (handle->hooks->pfnTell( handle, &pos )!=0) {
            pos = -1;
        }
    } else {
        pos = -1;
    }

    if (pos != -1) {
        /* Adjust real position by number of characters in put back buffer */
        pos -= handle->putback_size;

        /* if in random mode, divide by reclen */
        if( handle->mode == FB_FILE_MODE_RANDOM )
            pos /= handle->len;

    }

	FB_UNLOCK();

	return pos + 1;
}

/*:::::*/
FBCALL long fb_FileTell( int fnum )
{
    return fb_FileTellEx( FB_FILE_TO_HANDLE(fnum) );
}

