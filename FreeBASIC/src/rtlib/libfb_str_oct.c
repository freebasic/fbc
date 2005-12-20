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
 * str_oct.c -- oct$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static char *hFillDigits( char *buf, int digits, int totdigs, int cnt )
{
	if( digits > 0 )
	{
		digits -= totdigs - cnt;
		while( digits > 0 )
		{
			*buf++ = '0';
			--digits;
		}
	}

	return buf;
}

/*:::::*/
static FBSTRING *hOCT ( unsigned int num, int len, int digits )
{
	FBSTRING *dst;
	char *buf;
	int	i, totdigs, rem;

	totdigs = ((len * 8) / 3) + 1;

	if( digits > 0 )
	{
		if( digits < totdigs )
			totdigs = digits;
		else if( digits > totdigs )
			digits = totdigs;
	}

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, totdigs );
	if( dst == NULL )
		return &fb_strNullDesc;

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
		/* too small? */
		if( totdigs < 3 )
		{
			rem = 0;
			num <<= ((sizeof(int)*8) - totdigs * 3);
		}
		else
		{
			rem = totdigs % 3;
			num <<= ((sizeof(int)*8) - ((totdigs-(rem == 0?0:1)) * 3 + rem));
		}

		/* remainder? */
		if( rem > 0 )
		{
			if( num > (0xFFFFFFFFUL >> rem) )
			{
				buf = hFillDigits( buf, digits, totdigs, 1 );
				*buf++ = '0' + ((num & ~(0xFFFFFFFFUL >> rem)) >> (sizeof(int)*8-rem));
			}

			num <<= rem;
			i = 1;
		}
		else
			i = 0;

		/* check for 0's at msb? */
		if( buf == dst->data )
		{
			for( ; i < totdigs; i++, num <<= 3 )
				if( num > 0x1FFFFFFFUL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			if( num > 0x1FFFFFFFUL )
				*buf++ = '0' + ((num & 0xE0000000UL) >> (sizeof(int)*8-3));
			else
				*buf++ = '0';
	}

	/* add null-term */
	*buf = '\0';

    fb_hStrSetLength( dst, buf - dst->data );

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_OCT_b ( unsigned char num )
{
	return hOCT( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_OCT_s ( unsigned short num )
{
	return hOCT( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_OCT_i ( unsigned int num )
{
	return hOCT( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FBSTRING *fb_OCTEx_i ( unsigned int num, int digits )
{
	return hOCT( num, sizeof( int ), digits );
}

