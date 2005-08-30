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
 * str_rtrimany.c -- ltrim$ ANY function
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <malloc.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_LTrimAny ( FBSTRING *src, FBSTRING *pattern )
{
    const char *pachText = NULL;
	FBSTRING 	*dst;
	size_t 		len;

    if( src == NULL ) {
        fb_hStrDelTemp( pattern );
        return &fb_strNullDesc;
    }

   	FB_STRLOCK();

	len = 0;
	if( src->data != NULL )
    {
        size_t len_pattern = FB_STRSIZE( pattern );
        pachText = src->data;
        len = FB_STRSIZE( src );
		while ( len != 0 )
        {
            size_t i;
            for( i=0; i!=len_pattern; ++i ) {
                if( FB_MEMCHR( pattern->data, *pachText, len_pattern )!=NULL ) {
                    break;
                }
            }
            if( i==len_pattern ) {
                break;
            }
            --len;
            ++pachText;
		}
	}

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_hStrCopy( dst->data, pachText, len );
		}
		else
			dst = &fb_strNullDesc;
    }
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );
    fb_hStrDelTemp_NoLock( pattern );

   	FB_STRUNLOCK();

	return dst;
}

