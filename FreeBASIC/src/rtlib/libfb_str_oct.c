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
	int	i, totdigs;

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
		/* enough to fit? */
		if( (totdigs * 3 < (sizeof(int)*8)) )
		{
			num <<= (sizeof(int)*8) - (totdigs*3);
			i = 0;
        }
		/* too big.. */
		else
		{
			if( num > (0xFFFFFFFFUL >> 2) )
			{
				buf = hFillDigits( buf, digits, totdigs, 0 );
				*buf++ = '0' + ((num & ~(0xFFFFFFFFUL >> 2)) >> (sizeof(int)*8-2));
			}

			num <<= 2;
			i = 1;
		}

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
			*buf++ = '0' + ((num & 0xE0000000UL) >> (sizeof(int)*8-3));
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
FBCALL FBSTRING *fb_OCTEx_b ( unsigned char num, int digits )
{
	return hOCT( num, sizeof( char ), digits );
}

/*:::::*/
FBCALL FBSTRING *fb_OCTEx_s ( unsigned short num, int digits )
{
	return hOCT( num, sizeof( short ), digits );
}

/*:::::*/
FBCALL FBSTRING *fb_OCTEx_i ( unsigned int num, int digits )
{
	return hOCT( num, sizeof( int ), digits );
}

