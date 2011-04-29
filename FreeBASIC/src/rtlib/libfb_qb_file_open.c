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
 * file_openqb - QB compatible OPEN
 *
 * chng: dec/2006 written [cha0s]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_FileOpenQB
	(
		FBSTRING *str,
		unsigned int mode,
		unsigned int access,
		unsigned int lock,
		int fnum,
		int len
	)
{
	if( !FB_FILE_INDEX_VALID( fnum ) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	int str_len = FB_STRSIZE( str );
	
	if( !str_len || (str->data == NULL) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );		
		
	/* serial? */
	if( (str_len > 3) && (strncasecmp( str->data, "COM", 3 ) == 0) )
	{
		int i = 3;
		while( (i < str_len) && (str->data[i] >= '0') && (str->data[i] <= '9' ) )
			++i;

		if( str->data[i] == ':' )
		{
			return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
									 str,
									 mode,
									 access,
									 lock,
									 len,
									 FB_FILE_ENCOD_ASCII,
									 fb_DevComOpen );
		}
	}
	/* parallel? */
	else if( (str_len > 3) && (strncasecmp( str->data, "LPT", 3 ) == 0) )
	{
		int i = 3;
		while( (i < str_len) && (str->data[i] >= '0') && (str->data[i] <= '9' ) )
			++i;

		if( str->data[i] == ':' )
		{
			return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
									 str,
									 mode,
									 access,
									 lock,
									 len,
									 FB_FILE_ENCOD_ASCII,
									 fb_DevLptOpen );
		}
	}
	/* default printer? */
	else if( (str_len == 4) && (strcasecmp( str->data, "PRN:" ) == 0) )
	{
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevLptOpen );
	}
	/* console? */
	else if( (str_len == 5) && (strcasecmp( str->data, "CONS:" ) == 0) )
	{
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevConsOpen );

	}
	/* screen? */
	else if( (str_len == 5) && (strcasecmp( str->data, "SCRN:" ) == 0) )
	{
		fb_DevScrnInit( );
	
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevScrnOpen );
	}
	/* pipe? */
	else if( (str_len == 5) && (strcasecmp( str->data, "PIPE:" ) == 0) )
	{
		return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
								 str,
								 mode,
								 access,
								 lock,
								 len,
								 FB_FILE_ENCOD_ASCII,
								 fb_DevPipeOpen );
	}
	
	/* ordinary file */
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}

