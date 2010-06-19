/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * file_putback_wstr - ungetwc-like function
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
int fb_FilePutBackWstrEx( FB_FILE *handle, const FB_WCHAR *src, size_t chars )
{
    int res, bytes;
    char *dst;

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
        if( handle->putback_size )
            memmove( handle->putback_buffer + bytes,
                     handle->putback_buffer,
                     handle->putback_size );

        handle->putback_size += bytes;

        /* note: if encoding != ASCII, putback buffer will be in
           wchar format, not in UTF */
        if( handle->encod != FB_FILE_ENCOD_ASCII )
        	memcpy( handle->putback_buffer, src, bytes );
        else
        {
        	/* wchar to char */
        	dst = handle->putback_buffer;
        	while( chars-- > 0 )
        		*dst++ = *src++;
        }
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_FilePutBackWstr( int fnum, const FB_WCHAR *src, size_t chars )
{
    return fb_FilePutBackWstrEx( FB_FILE_TO_HANDLE(fnum), src, chars );
}

