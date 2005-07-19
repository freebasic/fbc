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
 * str_hex_lng.c -- hex$ routine for long long's
 *
 * chng: apr/2005 written [v1ctor]
 *       jul/2005 rewritten to use consistent case across platforms [DrV] 
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"

static char hex_table[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

/*:::::*/
FBCALL FBSTRING *fb_HEX_l ( unsigned long long num )
{
	FBSTRING 	*dst;
	char buf[17], *src;
	unsigned int lodw, hidw;

	FB_STRLOCK();

	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, sizeof( long long ) * 2 );
		
		lodw = (unsigned int)(num & 0xFFFFFFFF);
		hidw = (unsigned int)(num >> 32);
		
		/* convert */
		buf[0]  = hex_table[(hidw >> 28) & 0xF];
		buf[1]  = hex_table[(hidw >> 24) & 0xF];
		buf[2]  = hex_table[(hidw >> 20) & 0xF];
		buf[3]  = hex_table[(hidw >> 16) & 0xF];
		buf[4]  = hex_table[(hidw >> 12) & 0xF];
		buf[5]  = hex_table[(hidw >> 8 ) & 0xF];
		buf[6]  = hex_table[(hidw >> 4 ) & 0xF];
		buf[7]  = hex_table[(hidw      ) & 0xF];		
		buf[8]  = hex_table[(lodw >> 28) & 0xF];
		buf[9]  = hex_table[(lodw >> 24) & 0xF];
		buf[10] = hex_table[(lodw >> 20) & 0xF];
		buf[11] = hex_table[(lodw >> 16) & 0xF];
		buf[12] = hex_table[(lodw >> 12) & 0xF];
		buf[13] = hex_table[(lodw >> 8 ) & 0xF];
		buf[14] = hex_table[(lodw >> 4 ) & 0xF];
		buf[15] = hex_table[(lodw      ) & 0xF];
		buf[16] = '\0';
		
		/* find leftmost nonzero digit */
		for (src = buf; *src == '0'; src++);
		
		memcpy(dst->data, src, 17 - (src - buf));

		dst->len = 16 - (src - buf);
		dst->len |= FB_TEMPSTRBIT;
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	return dst;
}

