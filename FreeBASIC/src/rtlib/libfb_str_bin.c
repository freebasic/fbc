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
 * str_bin.c -- bin$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static FBSTRING *hBIN ( unsigned int num, int len, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs;
	unsigned int mask;

	if( digits > 0 )
	{
		totdigs = (digits < len << 3? digits: len << 3);
		if( digits > len << 3 )
			digits = len << 3;
	}
	else
		totdigs = len << 3;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, totdigs );
	if( dst == NULL )
		return &__fb_ctx.null_desc;

	/* convert */
	buf = dst->data;

	if( num == 0 )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = '0';
	}
	else
	{
		mask = 1UL << (totdigs-1);

		for( i = 0; i < totdigs; i++, num <<= 1 )
			if( num & mask )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = '0';
		}

		for( ; i < totdigs; i++, num <<= 1 )
			if( num & mask )
				*buf++ = '1';
			else
				*buf++ = '0';
	}

	/* add null-term */
	*buf = '\0';

    fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_b ( unsigned char num )
{
	return hBIN( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_s ( unsigned short num )
{
	return hBIN( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_i ( unsigned int num )
{
	return hBIN( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_BINEx_i ( unsigned int num, int digits )
{
	return hBIN( num, sizeof( int ), digits );
}

