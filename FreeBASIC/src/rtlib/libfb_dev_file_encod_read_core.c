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
 * dev_efile_read_core - UTF-encoded to char or wchar file reading
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include <malloc.h>

#include "fb.h"
#include "fb_rterr.h"

/*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
 * to char                                                                              *
 *::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/

/*:::::*/
static int hReadUTF8ToChar( FILE *fp, char *dst, int max_chars )
{
	/* !!!WRITEME!!! */
	return 0;
}

/*:::::*/
static int hReadUTF16ToChar( FILE *fp, char *dst, int max_chars )
{
	int chars;
	UTF_16 c;

	chars = max_chars;
    while( chars > 0 )
    {
    	if( fread( &c, sizeof( UTF_16 ), 1, fp ) != 1 )
    		break;

		if( c > 255 )
		{
			if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
			{
    			if( fread( &c, sizeof( UTF_16 ), 1, fp ) != 1 )
    				break;
    		}
    		c = '?';
    	}

		*dst++ = c;
		--chars;
	}

	return max_chars - chars;
}

/*:::::*/
static int hReadUTF32ToChar( FILE *fp, char *dst, int max_chars )
{
	int chars;
	UTF_32 c;

	chars = max_chars;
    while( chars > 0 )
    {
    	if( fread( &c, sizeof( UTF_32 ), 1, fp ) != 1 )
    		break;

		if( c > 255 )
			c = '?';

		*dst++ = c;
		--chars;
	}

	return max_chars - chars;
}

/*:::::*/
int fb_hFileRead_UTFToChar( FILE *fp, FB_FILE_ENCOD encod, char *dst, int max_chars )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hReadUTF8ToChar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF16:
		return hReadUTF16ToChar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF32:
		return hReadUTF32ToChar( fp, dst, max_chars );

	default:
		return 0;
	}

}

/*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*
 * to wchar                                                                             *
 *::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/

/*:::::*/
static int hReadUTF8ToWchar( FILE *fp, FB_WCHAR *dst, int max_chars )
{
	/* !!!WRITEME!!! */
	return 0;
}

/*:::::*/
static int hUTF16ToUTF32( FILE *fp, FB_WCHAR *dst, int max_chars )
{
    UTF_32 c, c2;
    int chars;

    chars = max_chars;
    while( chars > 0 )
    {
    	if( fread( &c, sizeof( UTF_16 ), 1, fp ) != 1 )
    		break;

		c &= 0x0000FFFF;
		if( c >= UTF16_SUR_HIGH_START && c <= UTF16_SUR_HIGH_END )
		{
    		if( fread( &c2, sizeof( UTF_16 ), 1, fp ) != 1 )
    			break;

			c = ((c - UTF16_SUR_HIGH_START) << UTF16_HALFSHIFT) +
			     (c2 - UTF16_SUR_LOW_START) + UTF16_HALFBASE;
		}

		*dst++ = c;
		--chars;
    }

	return max_chars - chars;
}

/*:::::*/
static int hReadUTF16ToWchar( FILE *fp, FB_WCHAR *dst, int max_chars )
{
	int res = 0;

	/* same size? */
	if( sizeof( FB_WCHAR ) == sizeof( UTF_16 ) )
		return fread( (char *)dst, sizeof( UTF_16 ), max_chars, fp );

	/* convert.. */
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		res = hReadUTF16ToChar( fp, (char *)dst, max_chars );
		break;

	case sizeof( UTF_16 ):
		res = hUTF16ToUTF32( fp, dst, max_chars );
		break;
	}

	return res;
}

/*:::::*/
static int hUTF32ToUTF16( FILE *fp, FB_WCHAR *dst, int max_chars )
{
    UTF_32 c;
    int chars;

    chars = max_chars;
    while( chars > 0 )
    {
    	if( fread( &c, sizeof( UTF_32 ), 1, fp ) != 1 )
    		break;

		if( c > UTF16_MAX_BMP )
		{
			if( chars > 1 )
			{
				*dst++ = (UTF_16)((c >> UTF16_HALFSHIFT) + UTF16_SUR_HIGH_START);
				--chars;
			}

			c = ((c & UTF16_HALFMASK) + UTF16_SUR_LOW_START);
		}

		*dst++ = (UTF_16)c;
		--chars;
    }

	return max_chars - chars;
}

/*:::::*/
static int hReadUTF32ToWchar( FILE *fp, FB_WCHAR *dst, int max_chars )
{
	int res = 0;

	/* same size? */
	if( sizeof( FB_WCHAR ) == sizeof( UTF_32 ) )
		return fread( (char *)dst, sizeof( UTF_32 ), max_chars, fp );

	/* convert.. */
	switch( sizeof( FB_WCHAR ) )
	{
	case sizeof( char ):
		res = hReadUTF32ToChar( fp, (char *)dst, max_chars );
		break;

	case sizeof( UTF_32 ):
		res = hUTF32ToUTF16( fp, dst, max_chars );
		break;
	}

	return res;
}

/*:::::*/
int fb_hFileRead_UTFToWchar( FILE *fp, FB_FILE_ENCOD encod, FB_WCHAR *dst, int max_chars )
{
	switch( encod )
	{
	case FB_FILE_ENCOD_UTF8:
		return hReadUTF8ToWchar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF16:
		return hReadUTF16ToWchar( fp, dst, max_chars );

	case FB_FILE_ENCOD_UTF32:
		return hReadUTF32ToWchar( fp, dst, max_chars );

	default:
		return 0;
	}

}
