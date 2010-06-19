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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

int fb_DevScrnRead( struct _FB_FILE *handle, void* value, size_t *pLength )
{
    size_t length;
    DEV_SCRN_INFO *info;
    int copy_length;
    char *pachBuffer = (char*) value;

    FB_LOCK();

    DBG_ASSERT(pLength!=NULL);
    length = *pLength;

    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;

    while( length > 0 ) {
        copy_length = (length > info->length) ? info->length : length;
        if (copy_length==0) {

        	while( fb_KeyHit( ) == 0 )
           		fb_Delay( 25 );				/* release time slice */

            fb_DevScrnFillInput( info );
            if( info->length != 0 )
                continue;

            break;
        }
        memcpy(pachBuffer, info->buffer, copy_length);
        info->length -= copy_length;
        if (info->length!=0) {
            memmove(info->buffer,
                    info->buffer + copy_length,
                    info->length);
        }
        length -= copy_length;
        pachBuffer += copy_length;
    }

    FB_UNLOCK();

    if (length!=0)
        memset(pachBuffer, 0, length);

    *pLength -= length;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


/*:::::*/
static int hReadFromStdin( struct _FB_FILE *handle, void* dst, size_t *pLength )
{
    return fb_DevFileRead( NULL, dst, pLength );
}

/*:::::*/
void fb_DevScrnInit_Read( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnRead == NULL )
    {
    	FB_HANDLE_SCREEN->hooks->pfnRead =
    				(fb_IsRedirected( TRUE )? hReadFromStdin : fb_DevScrnRead);
    }
}
