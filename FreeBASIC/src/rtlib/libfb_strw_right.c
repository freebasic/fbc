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
 * strw_right.c -- rightw$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrRight ( const FB_WCHAR *src, int chars )
{
	FB_WCHAR *dst;
	int len, src_len;

	if( src == NULL )
		return NULL;

	src_len = fb_wstr_Len( src );
	if( (chars <= 0) || (src_len == 0) )
		return NULL;

	if( chars > src_len )
		len = src_len;
	else
		len = chars;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len );
	if( dst != NULL )
	{
		/* simple rev copy */
		fb_wstr_Copy( dst, fb_wstr_OffsetOf( src, src_len - len ), len );
	}

	return dst;
}
