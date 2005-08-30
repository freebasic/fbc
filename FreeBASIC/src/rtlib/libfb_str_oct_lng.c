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
 * str_oct.c -- oct$ routine for long long's
 *
 * chng: apr/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_OCT_l ( unsigned long long num )
{
	FBSTRING 	*dst;

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, sizeof( long long ) * 4 );
	if( dst != NULL )
	{
		/* convert */
#ifdef TARGET_WIN32
		_i64toa( num, dst->data, 8 );
#else
		sprintf( dst->data, "%llo", num );
#endif

        fb_hStrSetLength( dst, strlen( dst->data ) );
	}
	else
		dst = &fb_strNullDesc;

	return dst;
}

