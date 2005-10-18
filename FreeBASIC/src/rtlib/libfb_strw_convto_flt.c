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
 * strw_convto_flt.c -- strw$ routines for float and double
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL FB_WCHAR *fb_FloatToWstr ( float num )
{
	FB_WCHAR *dst, *d;
    int len;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( 8+8 );
	if( dst != NULL )
    {
		/* convert */
		swprintf( dst, _LC("%.8g"), num );

		/* skip the dot at end if any */
		len = fb_wstr_Len( dst );
		if( len > 0 )
		{
			d = fb_wstr_OffsetOf( dst, len-1 );
			if( fb_wstr_GetCharAt( d, 0 ) == _LC('.') )
				fb_wstr_SetCharAt( d, 0, _LC('\0') );
        }
    }

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_DoubleToWstr ( double num )
{
	FB_WCHAR *dst, *d;
	int len;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( 16+8 );
	if( dst != NULL )
	{
		/* convert */
		swprintf( dst, _LC("%.16g"), num);

		/* skip the dot at end if any */
		len = fb_wstr_Len( dst );
		if( len > 0 )
		{
			d = fb_wstr_OffsetOf( dst, len-1 );
			if( fb_wstr_GetCharAt( d, 0 ) == _LC('.') )
				fb_wstr_SetCharAt( d, 0, _LC('\0') );
        }
	}

	return dst;
}



