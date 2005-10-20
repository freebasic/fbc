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
 * strw_assign.c -- unicode string assigning function
 *
 * chng: ago/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_WstrAssign ( FB_WCHAR *dst, int dst_chars, FB_WCHAR *src )
{
	int src_chars;

	if( dst == NULL )
		return dst;

	if( src == 0 )
		src_chars = 0;
	else
		src_chars = fb_wstr_Len( src );

	/* src NULL? */
	if( src_chars == 0 )
	{
		*dst = 0;
	}
	else
	{
		if( dst_chars > 0 )
		{
			--dst_chars;						/* less the null-term */
			/* not enough? clamp */
			if( dst_chars < src_chars )
				src_chars = dst_chars;
		}

		fb_wstr_Copy( dst, src, src_chars );
	}

	return dst;
}

