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
 * str_hex.c -- hex$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *       jul/2005 rewritten to use consistent case across platforms [DrV]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


/*:::::*/
static FBSTRING *hHEX ( unsigned int num, int len )
{
	FBSTRING 	 *dst;
	char		 *buf;
	int			 i;

	FB_STRLOCK();

	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, len * 2 );
		
		/* convert */
		buf = dst->data;

		if( num == 0 )
			*buf++ = '0';
		else
		{
			num <<= (32 - (len*8));
	
			for( i = 0; i < len*2; i++, num <<= 4 )
				if( num > 0x0FFFFFFF )
					break;

			for( ; i < len*2; i++, num <<= 4 )
				if( num > 0x0FFFFFFF )
					*buf++ = hex_table[(num & 0xF0000000) >> 28];
				else 
					*buf++ = '0';
		}
		
		/* add null-term */
		*buf = '\0';
		
		dst->len = buf - dst->data;
		dst->len |= FB_TEMPSTRBIT;
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_b ( unsigned char num )
{
	return hHEX( num, sizeof( char ) );
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_s ( unsigned short num )
{
	return hHEX( num, sizeof( short ) );
}

/*:::::*/
FBCALL FBSTRING *fb_HEX_i ( unsigned int num )
{
	return hHEX( num, sizeof( int ) );
}

