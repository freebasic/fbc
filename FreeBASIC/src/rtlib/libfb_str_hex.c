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
 * str_hex.c -- hex$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *       jul/2005 rewritten to use consistent case across platforms [DrV]
 *
 */

#include <stdlib.h>
#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


/*:::::*/
static FBSTRING *hHEX ( unsigned int num, int len, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs;

	if( digits > 0 )
	{
		totdigs = (digits < len << 1? digits: len << 1);
		if( digits > len << 1 )
			digits = len << 1;
	}
	else
		totdigs = len << 1;

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
		num <<= ((sizeof(int) << 3) - (totdigs << 2));

		for( i = 0; i < totdigs; i++, num <<= 4 )
			if( num > 0x0FFFFFFF )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = '0';
		}

		for( ; i < totdigs; i++, num <<= 4 )
			*buf++ = hex_table[(num & 0xF0000000) >> 28];
	}

	/* add null-term */
	*buf = '\0';

	fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_b ( unsigned char num )
{
	return hHEX( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_s ( unsigned short num )
{
	return hHEX( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_i ( unsigned int num )
{
	return hHEX( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_HEXEx_i ( unsigned int num, int digits )
{
	return hHEX( num, sizeof( int ), digits );
}

