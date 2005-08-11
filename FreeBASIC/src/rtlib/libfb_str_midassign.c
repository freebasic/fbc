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
 * str_midassign.c -- mid$ statement
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL void fb_StrAssignMid ( FBSTRING *dst, int start, int len, FBSTRING *src )
{
    int 	src_len, dst_len;

	FB_STRLOCK();

    if( (dst == NULL) || (dst->data == NULL) || (FB_STRSIZE( dst ) == 0) )
    {
    	fb_hStrDelTemp( src );
    	fb_hStrDelTemp( dst );
    	FB_STRUNLOCK();
    	return;
    }

    if(	(src == NULL) || (src->data == NULL) || (FB_STRSIZE( src ) == 0) ) {
        fb_hStrDelTemp( src );
    	fb_hStrDelTemp( dst );
    	FB_STRUNLOCK();
    	return ;
    }


	src_len = FB_STRSIZE( src );
	dst_len = FB_STRSIZE( dst );

    if( (start > 0) && (start <= dst_len) )
    {
		--start;

        if( (len < 1) || (len > src_len) )
			len = src_len;

        if( start + len > dst_len )
        	len = (dst_len - start) - 1;

		memcpy( dst->data + start, src->data, len );
    }

	/* del if temp */
	fb_hStrDelTemp( src );
    fb_hStrDelTemp( dst );

   	FB_STRUNLOCK();
}
