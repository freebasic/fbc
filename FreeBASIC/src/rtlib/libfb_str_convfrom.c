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
 * str_convfrom.c -- val function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
static int fb_hStrToInt( char *s, int len, int radix )
{
	int c, v;

	v = 0;

	switch( radix )
	{
		/* hex */
		case 16:
			while( --len >= 0 )
			{
				c = (int)*s++ - 48;
                if( c > 9 )
                	c -= (65 - 57 - 1);
				if( c > 16 )
					c -= (97 - 65);

				v = (v * 16) + c;
			}
		break;

		/* oct */
		case 8:
			while( --len >= 0 )
				v = (v * 8) + ((int)*s++ - 48);
		break;

		/* bin */
		case 2:
			while( --len >= 0 )
				v = (v * 2) + ((int)*s++ - 48);
		break;
	}

	return v;
}

/*:::::*/
FBCALL double fb_hStr2Double( char *src, int len )
{
    char 	*p;
    int 	radix;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (int)(p - src);
	if( len < 1 )
		return 0.0;

	else if( (len >= 2) && (p[0] == '&') )
	{
		radix = 0;
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

		if( radix != 0 )
			return (double)fb_hStrToInt( &p[2], len-2, radix );
	}
	return atof( p );

}

/*:::::*/
FBCALL double fb_VAL ( FBSTRING *str )
{
    double	val;

	if( str == NULL )
	    return 0.0;

	FB_STRLOCK();

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0.0;
	else
		val = fb_hStr2Double( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	FB_STRUNLOCK();

	return val;
}


