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
 *	file_get_wstr - get # function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
int fb_FileGetWstrEx( FB_FILE *handle, fb_off_t pos, FB_WCHAR *dst, int dst_chars, size_t *bytesread )
{
    int res;

	if( bytesread )
		*bytesread = 0;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* perform call ... but only if there's data ... */
    if( (dst != NULL) && (dst_chars > 0) )
    {
        size_t chars;
        res = fb_FileGetDataEx( handle, pos, (void *)dst, dst_chars, &chars, TRUE, TRUE );

        /* add the null-term */
        if( res == FB_RTERROR_OK )
        	dst[chars] = _LC('\0');

		if( bytesread )
			*bytesread = chars;
    }
    else
		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	return res;
}

/*:::::*/
FBCALL int fb_FileGetWstr( int fnum, long pos, FB_WCHAR *dst, int dst_chars )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, NULL );
}

/*:::::*/
FBCALL int fb_FileGetWstrLarge( int fnum, long long pos, FB_WCHAR *dst, int dst_chars )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, NULL );
}

/*:::::*/
FBCALL int fb_FileGetWstrIOB( int fnum, long pos, FB_WCHAR *dst, int dst_chars, unsigned int *bytesread )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, bytesread );
}

/*:::::*/
FBCALL int fb_FileGetWstrLargeIOB( int fnum, long long pos, FB_WCHAR *dst, int dst_chars, unsigned int *bytesread )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, bytesread );
}
