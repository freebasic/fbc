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
 *	file_eof - eof function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_FileEof( int fnum )
{
	if( fnum < 1 || fnum > FB_MAX_FILES )
		return FB_TRUE;

	if( fb_fileTB[fnum-1].f == NULL )
		return FB_TRUE;

	if( fb_fileTB[fnum-1].type == FB_FILE_TYPE_NORMAL )
	{
		switch( fb_fileTB[fnum-1].mode )
		{
		case FB_FILE_MODE_BINARY:
		case FB_FILE_MODE_RANDOM:
		case FB_FILE_MODE_INPUT:
		case FB_FILE_MODE_BINARYINPUT:
			if( ftell( fb_fileTB[fnum-1].f ) >= fb_fileTB[fnum-1].size )
	        	return FB_TRUE;
    	    else
        		return FB_FALSE;
		}
	}

	return (feof( fb_fileTB[fnum-1].f ) == 0? FB_FALSE: FB_TRUE);
}

