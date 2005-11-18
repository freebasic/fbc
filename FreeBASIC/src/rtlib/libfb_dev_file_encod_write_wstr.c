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
 * dev_efile_write_wstr - UTF-encoded wstring file writing
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
int fb_DevFileWriteEncodWstr( struct _FB_FILE *handle, const FB_WCHAR* buffer, size_t len )
{
    FILE *fp;
    char *encod_buffer;
    int bytes;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* convert (note: only wstrings will be written using this function,
				so there's no binary data to care) */
	encod_buffer = fb_WCharToUTF( handle->encod,
								  buffer,
								  len / sizeof( FB_WCHAR ),
								  &bytes );

	if( encod_buffer != NULL )
	{
		/* do write */
		if( fwrite( encod_buffer, 1, bytes, fp ) != bytes )
		{
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_FILEIO );
		}

		if( encod_buffer != (char *)buffer )
			free( encod_buffer );
	}

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
