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
 *	file_put_wstr - put # function for wstrings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_FilePutWstrEx( FB_FILE *handle, long pos, FB_WCHAR *str, int len )
{
    int res;

	/* perform call ... but only if there's data ... */
    if( (str != NULL) && (len > 0) )
        res = fb_FilePutDataEx( handle, pos, (void *)str, len, TRUE, TRUE, TRUE );
    else
    	res = fb_ErrorSetNum( FB_RTERROR_OK );

	return res;
}

/*:::::*/
FBCALL int fb_FilePutWstr( int fnum, long pos, FB_WCHAR *str, int str_len )
{
	return fb_FilePutWstrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len);
}

