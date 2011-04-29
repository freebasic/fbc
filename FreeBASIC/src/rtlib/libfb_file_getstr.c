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
 *	file_get - get # function for strings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"


/*:::::*/
int fb_FileGetStrEx( FB_FILE *handle, fb_off_t pos, void *str, int str_len, size_t *bytesread )
{
    int res;
    size_t len;
	char *data;

	if( bytesread )
		*bytesread = 0;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    /* get string len */
	FB_STRSETUP_DYN( str, str_len, data, len );

	/* perform call ... but only if there's data ... */
    if( (data != NULL) && (len > 0) ) {
        res = fb_FileGetDataEx( handle, pos, data, len, &len, TRUE, FALSE );
        data[len] = 0;                                /* add the null-term */
    } else {
		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	if( bytesread )
		*bytesread = len;

	/* del if temp */
	if( str_len == -1 )
		fb_hStrDelTemp( (FBSTRING *)str );		/* will free the temp desc if fix-len passed */

	return res;
}

/*:::::*/
FBCALL int fb_FileGetStr( int fnum, long pos, void *str, int str_len )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, NULL);
}

/*:::::*/
FBCALL int fb_FileGetStrLarge( int fnum, long long pos, void *str, int str_len )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, NULL);
}

/*:::::*/
FBCALL int fb_FileGetStrIOB( int fnum, long pos, void *str, int str_len, unsigned int *bytesread )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, bytesread);
}

/*:::::*/
FBCALL int fb_FileGetStrLargeIOB( int fnum, long long pos, void *str, int str_len, unsigned int *bytesread )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, bytesread);
}

