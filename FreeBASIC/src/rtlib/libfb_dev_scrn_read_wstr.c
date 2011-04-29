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
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

int fb_DevScrnReadWstr( struct _FB_FILE *handle, FB_WCHAR *dst, size_t *pchars )
{
    size_t chars;
    DEV_SCRN_INFO *info;
    int copy_chars;

    /* !!!FIXME!!! no unicode input supported */

    FB_LOCK();

    chars = *pchars;

    info = (DEV_SCRN_INFO*) FB_HANDLE_DEREF(handle)->opaque;

    while( chars > 0 )
    {
        int len = info->length / sizeof( FB_WCHAR );
        copy_chars = (chars > len) ? len : chars;
        if( copy_chars == 0 )
        {
        	while( fb_KeyHit( ) == 0 )
           		fb_Delay( 25 );				/* release time slice */

            fb_DevScrnFillInput( info );
            if( info->length != 0 )
                continue;

            break;
        }

        fb_wstr_ConvFromA( dst, chars, info->buffer );

        info->length -= copy_chars * sizeof( FB_WCHAR );
        if( info->length != 0 )
        {
            memmove( info->buffer,
                     info->buffer + copy_chars * sizeof( FB_WCHAR ),
                     info->length );
        }

        chars -= copy_chars;
        dst += copy_chars;
    }

    FB_UNLOCK();

    if( chars != 0 )
        memset( dst, 0, chars * sizeof( FB_WCHAR ) );

    *pchars -= chars;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static int hReadFromStdin( struct _FB_FILE *handle, FB_WCHAR *dst, size_t *pchars )
{
    return fb_DevFileReadWstr( NULL, dst, pchars );
}

/*:::::*/
void fb_DevScrnInit_ReadWstr( void )
{
	fb_DevScrnInit_NoOpen( );

    if( FB_HANDLE_SCREEN->hooks->pfnReadWstr == NULL )
    {
    	FB_HANDLE_SCREEN->hooks->pfnReadWstr =
    			(fb_IsRedirected( TRUE )? hReadFromStdin : fb_DevScrnReadWstr);
    }
}
