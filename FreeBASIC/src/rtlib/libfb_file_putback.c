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
 *	file_putback - some kind of ungetc function
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
int fb_FilePutBackEx( FB_FILE *handle, const void *src, size_t chars )
{
    int res, bytes;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    /* UTF? */
    if( handle->encod != FB_FILE_ENCOD_ASCII )
    	bytes = chars * sizeof( FB_WCHAR );
    else
    	bytes = chars;

    if( handle->putback_size + bytes > sizeof(handle->putback_buffer) )
    {
        res = fb_ErrorSetNum( FB_RTERROR_FILEIO );
    }
    else
    {
        /* note: if encoding != ASCII, putback buffer will be in
           wchar format, not in UTF */
        if( handle->putback_size )
        {
            memmove( handle->putback_buffer + bytes,
                     handle->putback_buffer,
                     handle->putback_size );
        }

        if( handle->encod == FB_FILE_ENCOD_ASCII )
        	memcpy( handle->putback_buffer, src, bytes );
        else
        {
    		/* char to wchar */
    		FB_WCHAR *dst = (FB_WCHAR *)handle->putback_buffer;
    		const char *patch = (const char *)src;
        	while( chars-- > 0 )
        		*dst++ = *patch++;
        }

        handle->putback_size += bytes;
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_FilePutBack( int fnum, const void *data, size_t length)
{
    return fb_FilePutBackEx( FB_FILE_TO_HANDLE(fnum), data, length );
}

