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
 * strw_ftoa.c -- float to wstring, internal usage
 *
 * chng: dec/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FB_WCHAR *fb_FloatExToWstr( double val, FB_WCHAR *buffer, int digits, int mask )
{
	FB_WCHAR *p, *r;
	FB_WCHAR fmtstr[16];
	int len;

	if( mask & FB_F2A_ADDBLANK )
		p = fb_wstr_OffsetOf( buffer, 1 );
	else
		p = buffer;

	/* no exponent? (if exp is too big, that won't matter) */
	if( (mask & FB_F2A_NOEXP) > 0 )
	{
		swprintf( fmtstr, _LC("%%.%df"), digits );
		swprintf( p, fmtstr, val );
	}
	else
	{
		swprintf( fmtstr, _LC("%%.%dg"), digits );
		swprintf( p, fmtstr, val );
	}

	len = fb_wstr_Len( p );

	if( len > 0 )
	{
		if( (mask & FB_F2A_NOEXP) > 0 )
		{
			/* skip the zeros at end */
			r = fb_wstr_OffsetOf( p, len - 1 );
			while( fb_wstr_GetCharRev( &r ) == _LC('0') )
			{
				fb_wstr_SetCharAt( r, 1, _LC('\0') );
				--len;
			}
		}

		/* skip the dot at end if any */
		if( len > 0 )
			if( fb_wstr_GetCharAt( p, len-1 ) == _LC('.') )
				fb_wstr_SetCharAt( p, len-1, _LC('\0') );
	}

	/* */
	if( (mask & FB_F2A_ADDBLANK) > 0 )
	{
		if( fb_wstr_GetCharAt( p, 0 ) != _LC('-') )
		{
			fb_wstr_SetCharAt( buffer, 0, _LC(' ') );
			return &buffer[0];
		}
		else
			return p;
	}
	else
		return p;

}

