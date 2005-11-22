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
 * file_inputstr - winput$ function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL FB_WCHAR *fb_FileWstrInput( int chars, int fnum )
{
    FB_FILE *handle;
	FB_WCHAR *dst;
    size_t len;
    int res = FB_RTERROR_OK;

	fb_DevScrnInit_ReadWstr( );

	FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
    if( !FB_HANDLE_USED(handle) )
    {
		FB_UNLOCK();
		return NULL;
	}

    dst = fb_wstr_AllocTemp( chars );
    if( dst != NULL )
    {
        size_t read_chars = 0;
        if( FB_HANDLE_IS_SCREEN(handle) )
        {
            dst[0] = _LC('\0');
            while( read_chars != chars )
            {
                len = chars - read_chars;
                res = fb_FileGetDataEx( handle,
                                        0,
                                        (void *)&dst[read_chars],
                                        &len,
                                        TRUE,
                                        TRUE );
                if( res != FB_RTERROR_OK )
                    break;

                read_chars += len;
                dst[read_chars] = _LC('\0');
            }
        }
        else
        {
            len = chars;
            res = fb_FileGetDataEx( handle,
                                    0,
                                    (void *)dst,
                                    &len,
                                    TRUE,
                                    TRUE );
            if( res == FB_RTERROR_OK )
                read_chars += chars;

        }

        if( read_chars != chars )
            dst[read_chars] = _LC('\0');
    }
    else
        res = FB_RTERROR_OUTOFMEM;

    if( res != FB_RTERROR_OK )
        dst = NULL;

    return dst;
}

