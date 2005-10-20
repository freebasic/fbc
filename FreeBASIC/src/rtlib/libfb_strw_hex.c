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
 * strw_hex.c -- hexw$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *       jul/2005 rewritten to use consistent case across platforms [DrV]
 *
 */

#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};


/*:::::*/
static FB_WCHAR *hHEX ( unsigned int num, int len )
{
	FB_WCHAR *dst, *buf;
	int	i;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( len * 2 );
	if( dst != NULL )
	{
		/* convert */
		buf = dst;

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
		*buf++ = '\0';
	}

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHex_b ( unsigned char num )
{
	return hHEX( num, sizeof( char ) );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHex_s ( unsigned short num )
{
	return hHEX( num, sizeof( short ) );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHex_i ( unsigned int num )
{
	return hHEX( num, sizeof( int ) );
}

