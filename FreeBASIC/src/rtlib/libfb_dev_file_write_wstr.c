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
 * dev_file_write_wstr - wstring to ascii file writing function
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_DevFileWriteWstr( struct _FB_FILE *handle, const FB_WCHAR* src, size_t chars )
{
    FILE *fp;
    char *buffer;
    int res;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	if( chars < FB_LOCALBUFF_MAXLEN )
		buffer = alloca( chars + 1 );
	else
		buffer = malloc( chars + 1 );

	/* convert to ascii, file should be opened with the ENCODING option
	   to allow UTF characters to be written */
	fb_wstr_ConvToA( buffer, src, chars );

	/* do write */
	res = fwrite( (void *)buffer, 1, chars, fp ) == chars;

	if( chars >= FB_LOCALBUFF_MAXLEN )
		free( buffer );

	FB_UNLOCK();

	return fb_ErrorSetNum( (res? FB_RTERROR_OK: FB_RTERROR_FILEIO) );
}
