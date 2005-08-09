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
 * str_lcase.c -- lcase$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <ctype.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_LCASE ( FBSTRING *src )
{
	FBSTRING 	*dst;
	int 		i, c, len = 0;
	char		*s, *d;

	if( src == NULL )
		return &fb_strNullDesc;

	FB_STRLOCK();
	
	if( src->data != NULL )
	{
		len = FB_STRSIZE( src );
		/* alloc temp string */
        dst = fb_hStrAllocTemp( NULL, len );
	}
	else
		dst = NULL;

	if( dst != NULL )
	{
		/* to lower */
		s = src->data;
		d = dst->data;
		for( i = 0; i < len; i++ )
		{
			c = FB_CHAR_TO_INT(*s++);

#if 0
			if( (c >= 65) && (c <= 90) )
                c += 97 - 65;
#else
            if( isupper( c ) )
                c = tolower( c );
#endif

			*d++ = (char)c;
		}

		/* null char */
		*d = '\0';
	}
	else
		dst = &fb_strNullDesc;

	/* del if temp */
	fb_hStrDelTemp( src );

	FB_STRUNLOCK();
	
	return dst;
}


