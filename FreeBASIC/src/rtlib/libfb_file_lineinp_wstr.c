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
 * file_lineinput_wstr - line input function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_FileLineInputWstr( int fnum, FB_WCHAR *dst, int max_chars )
{
    FB_FILE *handle = FB_FILE_TO_HANDLE(fnum);

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    if( handle->hooks->pfnReadLineWstr == NULL )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    return handle->hooks->pfnReadLineWstr( handle, dst, max_chars );
}

