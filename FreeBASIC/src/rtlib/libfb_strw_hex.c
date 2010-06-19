/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * strw_hex.c -- hexw$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"

static FB_WCHAR hex_table[16] = {_LC('0'),_LC('1'),_LC('2'),_LC('3'),
								 _LC('4'),_LC('5'),_LC('6'),_LC('7'),
								 _LC('8'),_LC('9'),_LC('A'),_LC('B'),
								 _LC('C'),_LC('D'),_LC('E'),_LC('F')};


/*:::::*/
static FB_WCHAR *hHEX ( unsigned int num, int len, int digits )
{
	FB_WCHAR *dst, *buf;
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
		num <<= ((sizeof(int) << 3) - (totdigs << 2));

		for( i = 0; i < totdigs; i++, num <<= 4 )
			if( num > 0x0FFFFFFF )
				break;

		if( digits > 0 )
		{
			digits -= totdigs - i;
			while( digits-- )
				*buf++ = _LC('0');
		}

		for( ; i < totdigs; i++, num <<= 4 )
			*buf++ = hex_table[(num & 0xF0000000) >> 28];
	}

	/* add null-term */
	*buf = _LC('\0');

	return dst;
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHex_b ( unsigned char num )
{
	return hHEX( num, sizeof( char ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHex_s ( unsigned short num )
{
	return hHEX( num, sizeof( short ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHex_i ( unsigned int num )
{
	return hHEX( num, sizeof( int ), 0 );
}

/*:::::*/
FBCALL FB_WCHAR *fb_WstrHexEx_i ( unsigned int num, int digits )
{
	return hHEX( num, sizeof( int ), digits );
}

