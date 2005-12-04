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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include "fb.h"
#include "fb_rterr.h"

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

    while( length!=0 ) {
        copy_length = (length > info->length) ? info->length : length;
        if (copy_length==0) {
            fb_DevScrnFillInput( info );
            if( info->length!=0 )
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
    size_t rlen, length;

    length = *pLength;

    FB_LOCK();

	/* do read */
	rlen = fread( dst, 1, length, stdin );
	/* fill with nulls if at eof */
	if( rlen != length )
        memset( ((char *)dst) + rlen, 0, length - rlen );

    *pLength = rlen;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
/*:::::*/
void fb_DevScrnInit_Read( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnRead == NULL )
    {
    	FB_HANDLE_SCREEN->hooks->pfnRead =
    				(fb_ConsoleIsRedirected( TRUE )? hReadFromStdin : fb_DevScrnRead);
    }
}
