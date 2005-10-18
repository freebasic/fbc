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
 * strw_midassign.c -- midw$ statement
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL void fb_WstrAssignMid ( FB_WCHAR *dst, int start, int len, const FB_WCHAR *src )
{
    int src_len, dst_len;

    if( (dst == NULL) || (src == NULL) )
    	return;

    dst_len = fb_wstr_Len( dst );
    if( dst_len == 0 )
    	return;

    src_len = fb_wstr_Len( src );
    if( src_len == 0 )
    	return;

    if( (start > 0) && (start <= dst_len) )
    {
		--start;

        if( (len < 1) || (len > src_len) )
			len = src_len;

        if( start + len > dst_len )
        	len = (dst_len - start) - 1;

		/* without the null-term */
		fb_wstr_Move( fb_wstr_OffsetOf( dst, start ), src, len );
    }
}
