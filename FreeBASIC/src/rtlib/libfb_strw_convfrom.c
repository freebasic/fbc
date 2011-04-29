/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * strw_convfrom.c -- valw function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL double fb_WstrToDouble( const FB_WCHAR *src, int len )
{
	const FB_WCHAR *p, *r;
	int radix;
	FB_WCHAR *q, c;
	int i;
	double ret;

	/* skip white spc */
	p = fb_wstr_SkipChar( src, len, 32 );

	len -= fb_wstr_CalcDiff( src, p );
	if( len < 1 )
		return 0.0;

	r = p;
	if( (len >= 2) && (*r++ == L'&') )
	{
		radix = 0;
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

			default: /* assume octal */
				radix = 8;
				r--;
				break;
		}

		if( radix != 0 )
			return (double)fb_WstrRadix2Longint( r, len - fb_wstr_CalcDiff( p, r ), radix );
	}

	/* Workaround: wcstod() does not allow 'd' as an exponent specifier on 
	 * non-win32 platforms, so create a temporary buffer and replace any 
	 * 'd's with 'e'
	 */
	q = malloc( (len + 1) * sizeof(FB_WCHAR) );
	for( i = 0; i < len; i++ )
	{
		c = p[i];
		if( c == L'd' || c == L'D' )
			++c;
		q[i]= c;
	}
	q[len] = L'\0';
	ret = wcstod( q, NULL );
	free( q );

	return ret;
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


