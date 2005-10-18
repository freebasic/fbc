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
 * strw_concatassign.c -- string concat and assign (s = s + expr) function
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrConcatAssign ( FB_WCHAR *dst, int dst_chars, const FB_WCHAR *src )
{
	int src_len, dst_len;

	/* NULL? */
	if( (dst == NULL) || (src == NULL) )
		return dst;

	src_len = fb_wstr_Len( src );
	if( src_len == 0 )
		return dst;

	dst_len = fb_wstr_Len( dst );

	/* don't check ptr's */
	if( dst_chars > 0 )
	{
		--dst_chars;							/* less the null-term */

		if( src_len > dst_chars - dst_len )
			src_len = dst_chars - dst_len;
	}

	/* copy the null-term too */
	fb_wstr_Move( fb_wstr_OffsetOf( dst, dst_len ), src, src_len + 1 );

	return dst;
}
