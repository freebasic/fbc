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
 * str_fill.c -- string$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_StrFill1 ( int cnt, int fchar )
{
	FBSTRING 	*dst;

	if( cnt > 0 )
	{
		FB_STRLOCK();
		
		/* alloc temp string */
		dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
		if( dst != NULL )
		{
			fb_hStrAllocTemp( dst, cnt );

			/* fill it */
			memset( dst->data, fchar, cnt );

			/* null char */
			dst->data[cnt] = '\0';
		}
		else
			dst = &fb_strNullDesc;
		
		FB_STRUNLOCK();
    }
	else
		dst = &fb_strNullDesc;

	return dst;
}


/*:::::*/
FBCALL FBSTRING *fb_StrFill2 ( int cnt, FBSTRING *src )
{
	FBSTRING 	*dst;
	int			fchar;

	FB_STRLOCK();
	
	if( (cnt > 0) && (src != NULL) && (src->data != NULL) && (FB_STRSIZE( src ) > 0) ) {
		fchar = (int)src->data[0];
		FB_STRUNLOCK();
		dst = fb_StrFill1( cnt, fchar );
		FB_STRLOCK();
	}
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( src );

	FB_STRUNLOCK();
	
	return dst;
}

