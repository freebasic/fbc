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

