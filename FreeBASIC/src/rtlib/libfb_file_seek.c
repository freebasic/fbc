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
 *	file_seek - seek function and stmt
 *
 * chng: oct/2004 written [marzec/v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"


/*:::::*/
FBCALL long fb_FileTell( int fnum )
{
	long pos;

	if( fnum < 1 || fnum > FB_MAX_FILES )
		return 0;

	if( fb_fileTB[fnum-1].f == NULL )
		return 0;

	pos = ftell( fb_fileTB[fnum-1].f );

	/* if in random mode, divide by reclen */
	if( fb_fileTB[fnum-1].mode == FB_FILE_MODE_RANDOM )
		pos /= fb_fileTB[fnum-1].len;

	return pos + 1;
}

/*:::::*/
FBCALL int fb_FileSeek( int fnum, long newpos )
{
	if( fnum < 1 || fnum > FB_MAX_FILES )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	if( fb_fileTB[fnum-1].f == NULL )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

	/* if in random mode, mul by reclen */
	if( fb_fileTB[fnum-1].mode == FB_FILE_MODE_RANDOM )
		newpos = (newpos-1) * fb_fileTB[fnum-1].len;
	else
		--newpos;

	return (fseek( fb_fileTB[fnum-1].f, newpos, SEEK_SET ) == 0? FB_RTERROR_OK: FB_RTERROR_FILEIO);
}

/*:::::*/
FBCALL long fb_FileLocation( int fnum )
{
    long pos;

	if( fnum < 1 || fnum > FB_MAX_FILES )
		return 0;

	if( fb_fileTB[fnum-1].f == NULL )
		return 0;

	pos = fb_FileTell( fnum );

	if( pos > 0 )
	{
		/* if in seq mode, divide by 128 (QB quirk) */
		switch( fb_fileTB[fnum-1].mode )
		{
		case FB_FILE_MODE_INPUT:
		case FB_FILE_MODE_OUTPUT:
			pos /= 128;
			break;
		default:
			--pos;
		}
	}

	return pos;
}

