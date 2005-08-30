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
 * str_convfrom_uint.c -- valuint function
 *
 * chng: mar/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL unsigned int fb_hStr2UInt( char *src, int len )
{
    char 	*p;
    int 	radix;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (int)(p - src);
	if( len < 1 )
		return 0;

	radix = 10;
	if( (len >= 2) && (p[0] == '&') )
	{
		switch( p[1] )
		{
			case 'h':
			case 'H':
				radix = 16;
			break;
			case 'o':
			case 'O':
				radix = 8;
			break;
			case 'b':
			case 'B':
				radix = 2;
			break;
		}

		if( radix != 10 )
			p += 2;
	}

	return strtoul( p, NULL, radix );
}

/*:::::*/
FBCALL unsigned int fb_VALUINT ( FBSTRING *str )
{
    unsigned int	val;

	if( str == NULL )
	    return 0;

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0;
	else
		val = fb_hStr2UInt( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	return val;
}
