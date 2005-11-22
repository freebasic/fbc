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
 * utf_convfrom_char - ascii to UTF conversion
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static char *hToUTF8( const char *src, int chars, char *dst, int *bytes )
{
	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * 2 );
			if( dst == NULL )
				return NULL;
		}

		fb_hCharToUTF8( src, chars, dst, bytes );
	}
	else
		*bytes = 0;

	return dst;
}

/*:::::*/
static char *hToUTF16( const char *src, int chars, char *dst, int *bytes )
{
	UTF_16 *p;

	/* !!!FIXME!!! only litle-endian supported */

	*bytes = chars * sizeof( UTF_16 );

	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * sizeof( UTF_16 ) );
			if( dst == NULL )
				return NULL;
		}
	}

	p = (UTF_16 *)dst;
	while( chars > 0 )
	{
		*p++ = (unsigned char)*src++;
		--chars;
	}

	return dst;
}

/*:::::*/
static char *hToUTF32( const char *src, int chars, char *dst, int *bytes )
{
	UTF_32 *p;

	/* !!!FIXME!!! only litle-endian supported */

	*bytes = chars * sizeof( UTF_32 );

	if( chars > 0 )
	{
		if( dst == NULL )
		{
			dst = malloc( chars * sizeof( UTF_32 ) );
			if( dst == NULL )
				return NULL;
		}
	}

	p = (UTF_32 *)dst;
	while( chars > 0 )
	{
		*p++ = (unsigned char)*src++;
		--chars;
	}

	return dst;
}

/*:::::*/
char *fb_CharToUTF( FB_FILE_ENCOD encod,
					const char *src, int chars,
					char *dst, int *bytes )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hToUTF8( src, chars, dst, bytes );

	case FB_FILE_ENCOD_UTF16:
		return hToUTF16( src, chars, dst, bytes );

	case FB_FILE_ENCOD_UTF32:
		return hToUTF32( src, chars, dst, bytes );

	default:
		return NULL;
	}
}
