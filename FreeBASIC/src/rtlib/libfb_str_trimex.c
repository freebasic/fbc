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
 * str_trim.c -- enhanced trim$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_TrimEx ( FBSTRING *src, FBSTRING *pattern )
{
	FBSTRING 	*dst;
	size_t       len;
	char		*p = NULL;

    if( src == NULL ) {
        fb_hStrDelTemp( pattern );
        return &fb_strNullDesc;
    }

	FB_STRLOCK();

	if( src->data != NULL )
    {
        size_t len_pattern = FB_STRSIZE( pattern );
        len = FB_STRSIZE( src );
        if( len >= len_pattern ) {
            if( len_pattern==1 ) {
                p = fb_hStrSkipChar( src->data,
                                     len,
                                     FB_CHAR_TO_INT(pattern->data[0]) );
                len = len - (int)(p - src->data);

            } else if( len_pattern != 0 ) {
                p = src->data;
                while (len >= len_pattern ) {
                    if( FB_MEMCMP( p, pattern->data, len_pattern )!=0 )
                        break;
                    p += len_pattern;
                    len -= len_pattern;
                }
            }
        }
        if( len >= len_pattern ) {
            if( len_pattern==1 ) {
                char *p_tmp =
                    fb_hStrSkipCharRev( p,
                                        len,
                                        FB_CHAR_TO_INT(pattern->data[0]) );
                len = (int)(p_tmp - p) + 1;

            } else if( len_pattern != 0 ) {
                size_t test_index = len - len_pattern;
                while (len >= len_pattern ) {
                    if( FB_MEMCMP( p + test_index,
                                   pattern->data,
                                   len_pattern )!=0 )
                        break;
                    test_index -= len_pattern;
                }
                len = test_index + len_pattern;

            }
        }
	}
	else
		len = 0;

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_hStrCopy( dst->data, p, len );
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




