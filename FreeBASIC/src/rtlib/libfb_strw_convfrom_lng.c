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
 * strw_convfrom_lng.c -- valwlng function
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL long long fb_WstrToLongint( const FB_WCHAR *src, int len )
{
    const FB_WCHAR *p, *r;
    int radix;

	/* skip white spc */
	p = fb_wstr_SkipChar( src, len, 32 );

	len -= fb_wstr_CalcDiff( src, p );
	if( len < 1 )
		return 0;

	radix = 10;
	r = p;
	if( (len >= 2) && (*r++ == L'&') )
	{
		switch( *r++ )
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

		if( radix != 10 )
		{
#ifdef TARGET_WIN32
			return fb_WstrRadix2Longint( r, len - fb_wstr_CalcDiff( p, r ), radix );
#else
			p = r;
#endif
		}
	}

#ifdef TARGET_WIN32
	return wtoll( p );
#else
	return wcstoll( p, NULL, radix );
#endif
}

/*:::::*/
FBCALL long long fb_WstrValLng ( const FB_WCHAR *str )
{
    long long val;
    int len;

	if( str == NULL )
	    return 0;

	len = fb_wstr_Len( str );
	if( len == 0 )
		val = 0;
	else
		val = fb_WstrToLongint( str, len );

	return val;
}

