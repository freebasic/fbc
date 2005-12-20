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
 * strw_oct.c -- octw$ routine for long long's
 *
 * chng: apr/2005 written [v1ctor]
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
FBCALL FB_WCHAR *fb_WstrOctEx_l ( unsigned long long num, int digits )
{
	FB_WCHAR *dst, *buf;
	int	i, totdigs, rem;

	totdigs = ((sizeof(long long)*8) / 3) + 1;

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
			num <<= ((sizeof(long long)*8) - totdigs * 3);
		}
		else
		{
			rem = totdigs % 3;
			num <<= ((sizeof(long long)*8) - ((totdigs-(rem == 0?0:1)) * 3 + rem));
		}

		/* remainder? */
		if( rem > 0 )
		{
			if( num > (0xFFFFFFFFFFFFFFFFULL >> rem) )
			{
				buf = hFillDigits( buf, digits, totdigs, 1 );
				*buf++ = _LC('0') + ((num & ~(0xFFFFFFFFFFFFFFFFULL >> rem))
								  >> (sizeof(long long)*8-rem));
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
				if( num > 0x1FFFFFFFFFFFFFFFULL )
					break;

			buf = hFillDigits( buf, digits, totdigs, i );
		}

		/* convert.. */
		for( ; i < totdigs; i++, num <<= 3 )
			if( num > 0x1FFFFFFFFFFFFFFFULL )
				*buf++ = _LC('0') + ((num & 0xE000000000000000ULL) >> (sizeof(long long)*8-3));
			else
				*buf++ = _LC('0');
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrOct_l ( unsigned long long num )
{
	return fb_WstrOctEx_l( num, 0 );
}

