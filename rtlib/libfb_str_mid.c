/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * str_mid.c -- mid$ function and mid$ statement.. ambiguity? no kidding!
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_StrMid ( FBSTRING *src, int start, int len )
{
    FBSTRING 	*dst;
    int			src_len;

    if( (src != NULL) && (src->data != NULL) && (FB_STRSIZE( src ) > 0) )
	{
        src_len = FB_STRSIZE( src );

        if( (start > 0) && (start <= src_len) )
        {
        	--start;

        	if( len < 1 )
        		len = src_len;

        	if( start + len > src_len )
        		len = src_len - start;

			/* alloc temp string */
			dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
			if( dst != NULL )
            {
				fb_hStrAllocTemp( dst, len );

				strncpy( dst->data, src->data + start, len );
				/* null term */
				dst->data[len] = '\0';
            }
        	else
        		dst = &fb_strNullDesc;
        }
        else
        	dst = &fb_strNullDesc;
	}
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( src );

	return dst;
}


/*:::::*/
FBCALL void fb_StrAssignMid ( FBSTRING *dst, int start, int len, FBSTRING *src )
{
    int 	src_len, dst_len;

    if( (dst == NULL) || (dst->data == NULL) || (FB_STRSIZE( dst ) == 0) )
    {
    	fb_hStrDelTemp( src );
    	return;
    }

    if(	(src == NULL) || (src->data == NULL) || (FB_STRSIZE( src ) == 0) )
    	return ;


	src_len = FB_STRSIZE( src );
	dst_len = FB_STRSIZE( dst );

    if( (start > 0) && (start <= dst_len) )
    {
		--start;

        if( (len < 1) || (len > src_len) )
			len = src_len;

        if( start + len > dst_len )
        	len = (dst_len - start) - 1;

		strncpy( dst->data + start, src->data, len );
    }

	/* del if temp */
	fb_hStrDelTemp( src );
}
