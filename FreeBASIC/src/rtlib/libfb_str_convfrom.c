/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * str_convfrom.c -- val function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
FBCALL double fb_hStr2Double( char *src, int len )
{
	char *p, *q, c;
	int radix;
	int i;
	int skip;
	double ret;

	/* skip white spc */
	p = fb_hStrSkipChar( src, len, 32 );

	len -= (int)(p - src);
	if( len < 1 )
		return 0.0;

	else if( (len >= 2) && (p[0] == '&') )
	{
		skip = 2;
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

			default: /* assume octal */
				radix = 8;
				skip = 1;
				break;
		}

		if( radix != 0 )
			return (double)fb_hStrRadix2Longint( &p[skip], len - skip, radix );
	}

	/* Workaround: strtod() does not allow 'd' as an exponent specifier on 
	 * non-win32 platforms, so create a temporary buffer and replace any 
     * 'd's with 'e'
     */
	q = malloc( len + 1 );
	for( i = 0; i < len; i++ )
	{
		c = p[i];
		if( c == 'd' || c == 'D' ) 
			++c;
		q[i] = c;
	}
	q[len] = '\0';

	ret = strtod( q, NULL );
	free( q );

	return ret;
}

/*:::::*/
FBCALL double fb_VAL ( FBSTRING *str )
{
    double	val;

	if( str == NULL )
	    return 0.0;

	if( (str->data == NULL) || (FB_STRSIZE( str ) == 0) )
		val = 0.0;
	else
		val = fb_hStr2Double( str->data, FB_STRSIZE( str ) );

	/* del if temp */
	fb_hStrDelTemp( str );

	return val;
}
