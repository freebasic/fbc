/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 *	file_put - put # function
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_FilePut( int fnum, long pos, void* value, unsigned int valuelen )
{
	int result;

	if( fnum < 1 || fnum > FB_MAX_FILES )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();
	
	if( fb_fileTB[fnum-1].f == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* seek to newpos */
	if( pos > 0 )
	{
		/* if in random mode, seek in reclen's */
		if( fb_fileTB[fnum-1].mode == FB_FILE_MODE_RANDOM )
			pos = (pos-1) * fb_fileTB[fnum-1].len;
		else
			--pos;

		result = fseek( fb_fileTB[fnum-1].f, pos, SEEK_SET );
		if( result != 0 ) {
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_FILEIO );
		}
	}

	/* do write */
	if( fwrite( value, 1, valuelen, fb_fileTB[fnum-1].f ) != valuelen ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}

    /* if in random mode, writes must be of reclen */
	if( fb_fileTB[fnum-1].mode == FB_FILE_MODE_RANDOM )
	{
		valuelen = fb_fileTB[fnum-1].len - valuelen;
		if( valuelen > 0 )
			fseek( fb_fileTB[fnum-1].f, valuelen, SEEK_CUR );
	}

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
