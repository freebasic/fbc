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
 * str_base.c -- hex$, oct$ and bin$ routines
 *
 * obs.: see str_convto.c about the fake len returned
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_HEX ( int num )
{
	FBSTRING 	*dst;

	FB_STRLOCK();
	
	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, sizeof( int ) * 2 );

		/* convert */
#ifdef WIN32
		_itoa( num, dst->data, 16 );
#else
		sprintf( dst->data, "%X", num );
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
FBCALL FBSTRING *fb_OCT ( int num )
{
	FBSTRING 	*dst;

	FB_STRLOCK();
	
	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, sizeof( int ) * 4 );

		/* convert */
#ifdef WIN32
		_itoa( num, dst->data, 8 );
#else
		sprintf( dst->data, "%o", num );
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
FBCALL FBSTRING *fb_BIN ( int num )
{
	FBSTRING 	*dst;
#ifndef WIN32
	int			i;
#endif

	FB_STRLOCK();
	
	/* alloc temp string */
	dst = (FBSTRING *)fb_hStrAllocTmpDesc( );
	if( dst != NULL )
	{
		fb_hStrAllocTemp( dst, sizeof( int ) * 8 );

		/* convert */
#ifdef WIN32
		_itoa( num, dst->data, 2 );
#else
		dst->data[0] = '\0';
		i = num;
		i |= (i >> 1);
		i |= (i >> 2);
		i |= (i >> 4);
		i |= (i >> 8);
		i |= (i >> 16);
		for (i = (i + 1) >> 1; i; i >>= 1)
			strcat(dst->data, (num & i) ? "1" : "0");
#endif

		dst->len = strlen( dst->data );				/* fake len */
		dst->len |= FB_TEMPSTRBIT;
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	return dst;
}

