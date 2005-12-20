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
 * strw_oct.c -- woct$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static FB_WCHAR *hFillDigits( FB_WCHAR *buf, int digits, int totdigs, int cnt )
{
	if( digits > 0 )
	{
		digits -= totdigs - cnt;
		while( digits > 0 )
		{
			*buf++ = _LC('0');
			--digits;
		}
	}

	return buf;
}

/*:::::*/
static FB_WCHAR *hOCT ( unsigned int num, int len, int digits )
{
	FB_WCHAR *dst, *buf;
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
    dst = fb_wstr_AllocTemp( totdigs );
	if( dst == NULL )
		return NULL;

	/* convert */
	buf = dst;

	if( num == 0 )
	{
		if( digits <= 0 )
			digits = 1;

		while( digits-- )
			*buf++ = _LC('0');
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
				*buf++ = _LC('0') + ((num & ~(0xFFFFFFFFUL >> rem)) >> (sizeof(int)*8-rem));
			}

			num <<= rem;
			i = 1;
		}
		else
			i = 0;

		/* check for 0's at msb? */
		if( buf == dst )
		{
			for( ; i < totdigs; i++, num <<= 3 )
				if( num > 0x1FFFFFFFUL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			if( num > 0x1FFFFFFFUL )
				*buf++ = _LC('0') + ((num & 0xE0000000UL) >> (sizeof(int)*8-3));
			else
				*buf++ = _LC('0');
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrOct_b ( unsigned char num )
{
	return hOCT( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrOct_s ( unsigned short num )
{
	return hOCT( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrOct_i ( unsigned int num )
{
	return hOCT( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrOctEx_i ( unsigned int num, int digits )
{
	return hOCT( num, sizeof( int ), digits );
}

