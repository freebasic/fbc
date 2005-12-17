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
 * strw_bin.c -- binw$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
static FB_WCHAR *hBin ( unsigned int num, int len, int digits )
{
	FB_WCHAR *dst, *buf;
	int i, totdigs;
	unsigned int mask;

	if( digits > 0 )
	{
		totdigs = (digits < len << 3? digits: len << 3);
		if( digits > len << 3 )
			digits = len << 3;
	}
	else
		totdigs = len << 3;

	/* alloc temp string, chars won't be above 127 */
    dst = fb_wstr_AllocTemp( digits );
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
		mask = 1UL << (totdigs-1);

		for( i = 0; i < totdigs; i++, num <<= 1 )
            if( num & mask )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = _LC('0');
		}

		for( ; i < totdigs; i++, num <<= 1 )
           	if( num & mask )
				*buf++ = _LC('1');
			else
               	*buf++ = _LC('0');
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBin_b ( unsigned char num )
{
	return hBin( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBin_s ( unsigned short num )
{
	return hBin( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBin_i ( unsigned int num )
{
	return hBin( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrBinEx_i ( unsigned int num, int digits )
{
	return hBin( num, sizeof( int ), digits );
}

