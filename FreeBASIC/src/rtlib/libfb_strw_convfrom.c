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
 * strw_convfrom.c -- valw function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL double fb_WstrToDouble( const FB_WCHAR *src, int len )
{
    FB_WCHAR *p, *r;
    int radix;

	/* skip white spc */
	p = fb_wstr_SkipChar( src, len, 32 );

	len -= fb_wstr_CalcDiff( src, p );
	if( len < 1 )
		return 0.0;

	r = p;
	if( (len >= 2) && (fb_wstr_GetChar( &r ) == L'&') )
	{
		radix = 0;
		switch( fb_wstr_GetChar( &r ) )
		{
			case L'h':
			case L'H':
				radix = 16;
				break;
			case L'o':
			case L'O':
				radix = 8;
				break;
			case L'b':
			case L'B':
				radix = 2;
				break;
		}

		if( radix != 0 )
			return (double)fb_WstrRadix2Int( r, len - fb_wstr_CalcDiff( p, r ), radix );
	}

	return wcstod( p, NULL );

}

/*:::::*/
FBCALL double fb_WstrVal ( const FB_WCHAR *str )
{
    double val;
    int len;

	if( str == NULL )
	    return 0.0;

	len = fb_wstr_Len( str );
	if( len == 0 )
		val = 0.0;
	else
		val = fb_WstrToDouble( str, len );

	return val;
}


