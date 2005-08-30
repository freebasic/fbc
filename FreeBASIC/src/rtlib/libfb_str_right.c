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
 * str_right.c -- right$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_RIGHT ( FBSTRING *src, int chars )
{
	FBSTRING 	*dst;
	int 		len, src_len;

	if( src == NULL )
		return &fb_strNullDesc;

   	FB_STRLOCK();

	src_len = FB_STRSIZE( src );
	if( (src->data != NULL)	&& (chars > 0) && (src_len > 0) )
    {
		if( chars > src_len )
			len = src_len;
		else
			len = chars;

		/* alloc temp string */
        dst = fb_hStrAllocTemp_NoLock( NULL, len );
		if( dst != NULL )
		{
			/* simple rev copy */
			fb_hStrCopy( dst->data, src->data + src_len - len, len );
		}
		else
			dst = &fb_strNullDesc;
	}
	else
        dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp_NoLock( src );

   	FB_STRUNLOCK();

	return dst;
}
