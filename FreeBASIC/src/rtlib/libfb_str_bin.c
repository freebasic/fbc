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
 * str_bin.c -- bin$ routines
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"

#ifndef WIN32
/*:::::*/
static void hToBin( unsigned int num, char *dst, int len )
{
	unsigned int mask = 1UL << ((len*8)-1);
	int i, iszero = 1;

	for( i = 0; i < len*8; i++ )
	{
		if( num & mask )
		{
			*dst++ = '1';
			iszero = 0;
		}
		else if( !iszero )
			*dst++ = '0';

		num <<= 1;
	}

	*dst = '\0';

}
#endif

/*:::::*/
static FBSTRING *hBIN ( unsigned int num, int len )
{
	FBSTRING 	*dst;

	FB_STRLOCK();

	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, len * 8 );

		/* convert */
#ifdef WIN32
		_itoa( num, dst->data, 2 );
#else
		hToBin( num, dst->data, len );
#endif

		dst->len = strlen( dst->data );				/* fake len */
		dst->len |= FB_TEMPSTRBIT;
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_b ( unsigned char num )
{
	return hBIN( num, sizeof( char ) );
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_s ( unsigned short num )
{
	return hBIN( num, sizeof( short ) );
}

/*:::::*/
FBCALL FBSTRING *fb_BIN_i ( unsigned int num )
{
	return hBIN( num, sizeof( int ) );
}

