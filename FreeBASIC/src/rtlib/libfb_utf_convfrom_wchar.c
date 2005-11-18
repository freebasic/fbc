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
 * utf_convfrom_wchar - wstring to UTF conversion
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static char *hToUTF8( const FB_WCHAR *src, int chars, int *bytes )
{
	/* !!!WRITEME!!! */
	*bytes = 0;
	return NULL;
}

/*:::::*/
static UTF_16 *hCharToUTF16( const FB_WCHAR *src, int chars, UTF_16 *dst, int *bytes )
{
	UTF_16 *buffer = dst;

	while( chars > 0 )
	{
		*dst++ = (unsigned char)*src++;
		--chars;
	}

	return buffer;
}

/*:::::*/
static UTF_16 *hUTF32ToUTF16( const FB_WCHAR *src, int chars, UTF_16 *dst, int *bytes )
{
	UTF_16 *buffer = dst;
	int i, dst_size = *bytes;
	UTF_32 c;

	i = 0;
	while( chars > 0 )
	{
		c = *src++;
		if( c > UTF16_MAX_BMP )
		{
			if( *bytes == dst_size )
			{
				dst_size += sizeof( UTF_16 ) * 8;
				buffer = realloc( buffer, dst_size );
				dst = (UTF_16 *)buffer;
			}

			*bytes += sizeof( UTF_16 );

			dst[i++] = (UTF_16)((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);
			dst[i++] = (UTF_16)((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
		}
		else
			dst[i++] = (UTF_16)c;

		--chars;
	}

	return buffer;
}

/*:::::*/
static char *hToUTF16( const FB_WCHAR *src, int chars, int *bytes )
{
	char *buffer = NULL;

	/* !!!FIXME!!! only litle-endian supported */

	*bytes = chars * sizeof( UTF_16 );

	/* same size? */
	if( sizeof( FB_WCHAR ) == sizeof( UTF_16 ) )
		return (char *)src;

	if( chars > 0 )
	{
		buffer = malloc( chars * sizeof( UTF_16 ) );
		if( buffer == NULL )
			return NULL;
	}

	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( UTF_8 ):
		return (char *)hCharToUTF16( src, chars, (UTF_16 *)buffer, bytes );
		break;

	case sizeof( UTF_32 ):
        return (char *)hUTF32ToUTF16( src, chars, (UTF_16 *)buffer, bytes );
		break;
	}
}

/*:::::*/
static UTF_32 *hCharToUTF32( const FB_WCHAR *src, int chars, UTF_32 *dst, int *bytes )
{
	UTF_32 *buffer = dst;

	while( chars > 0 )
	{
		*dst++ = (unsigned char)*src++;
		--chars;
	}

	return buffer;
}

/*:::::*/
static UTF_32 *hUTF16ToUTF32( const FB_WCHAR *src, int chars, UTF_32 *dst, int *bytes )
{
	UTF_32 *buffer = dst;
	UTF_32 c;

	while( chars > 0 )
	{
		c = (UTF_32)*src++;
		if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
		{
			c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
			     (((UTF_32)*src++) - UTF16_SUR_LOW_START) + UTF16_HALFBASE;

			*bytes -= sizeof( UTF_32 );
			--chars;
		}

		*dst++ = c;

		--chars;
	}

	return buffer;
}

/*:::::*/
static char *hToUTF32( const FB_WCHAR *src, int chars, int *bytes )
{
	char *buffer = NULL;

	/* !!!FIXME!!! only litle-endian supported */

	*bytes = chars * sizeof( UTF_32 );

	/* same size? */
	if( sizeof( FB_WCHAR ) == sizeof( UTF_32 ) )
		return (char *)src;

	if( chars > 0 )
	{
		buffer = malloc( chars * sizeof( UTF_32 ) );
		if( buffer == NULL )
			return NULL;
	}

	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( UTF_8 ):
		return (char *)hCharToUTF32( src, chars, (UTF_32 *)buffer, bytes );
		break;

	case sizeof( UTF_16 ):
        return (char *)hUTF16ToUTF32( src, chars, (UTF_32 *)buffer, bytes );
		break;
	}
}

/*:::::*/
char *fb_WCharToUTF( FB_FILE_ENCOD encod, const FB_WCHAR *src, int chars, int *bytes )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hToUTF8( src, chars, bytes );

	case FB_FILE_ENCOD_UTF16:
		return hToUTF16( src, chars, bytes );

	case FB_FILE_ENCOD_UTF32:
		return hToUTF32( src, chars, bytes );

	default:
		return NULL;
	}
}
