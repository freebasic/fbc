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
 * file_encod - string to file encoding function
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"


/*:::::*/
FB_FILE_ENCOD fb_hFileStrToEncoding( const char *encoding )
{
	if( encoding == NULL )
		return FB_FILE_ENCOD_DEFAULT;

	if( strncasecmp( encoding, "UTF", 3 ) == 0 )
	{
		encoding += 3;

		if( strcasecmp( encoding, "8" ) == 0 )
			return FB_FILE_ENCOD_UTF8;

		if( strcasecmp( encoding, "16" ) == 0 )
			return FB_FILE_ENCOD_UTF16;

		if( strcasecmp( encoding, "32" ) == 0 )
			return FB_FILE_ENCOD_UTF32;
	}
	else
	{
		if( strncasecmp( encoding, "ASC", 3 ) == 0 )
			return FB_FILE_ENCOD_ASCII;
	}

	return FB_FILE_ENCOD_DEFAULT;
}

