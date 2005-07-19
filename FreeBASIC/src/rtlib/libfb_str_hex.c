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
	FBSTRING 	*dst;
	char buf[9], *src;

	FB_STRLOCK();

	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, len * 2 );
		
		/* convert */
		buf[0] = hex_table[(num >> 28) & 0xF];
		buf[1] = hex_table[(num >> 24) & 0xF];
		buf[2] = hex_table[(num >> 20) & 0xF];
		buf[3] = hex_table[(num >> 16) & 0xF];
		buf[4] = hex_table[(num >> 12) & 0xF];
		buf[5] = hex_table[(num >> 8) & 0xF];
		buf[6] = hex_table[(num >> 4) & 0xF];
		buf[7] = hex_table[num & 0xF];
		buf[8] = '\0';
		
		/* find leftmost nonzero digit */
		for (src = buf; *src == '0'; src++);
		
		memcpy(dst->data, src, 9 - (src - buf));
		
		dst->len = 8 - (src - buf);
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

