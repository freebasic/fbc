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
 * str_convto_flt.c -- str$ routines for float and double
 *
 * obs.: the result string's len is being "faked" to appear as if it were shorter
 *       than the one that has to be allocated to fit _itoa and _gvct buffers.
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL FBSTRING *fb_FloatToStr ( float num )
{
	FBSTRING 	*dst;

	FB_STRLOCK();
	
	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, 8+8 );
	if( dst != NULL )
    {
        size_t tmp_len;

		/* convert */
#ifdef TARGET_WIN32
		_gcvt( (double)num, 8, dst->data );
#else
		sprintf( dst->data, "%.8g", num );
#endif

		tmp_len = strlen( dst->data );				/* fake len */

		/* skip the dot at end if any */
		if( tmp_len > 0 )
		{
			if( dst->data[tmp_len-1] == '.' )
			{
				dst->data[tmp_len-1] = '\0';
				--tmp_len;
			}
        }
        fb_hStrSetLength( dst, tmp_len );
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	return dst;
}

/*:::::*/
FBCALL FBSTRING *fb_DoubleToStr ( double num )
{
	FBSTRING 	*dst;

	FB_STRLOCK();

	/* alloc temp string */
    dst = fb_hStrAllocTemp( NULL, 16+8 );
	if( dst != NULL )
	{
        size_t tmp_len;

		/* convert */
#ifdef TARGET_WIN32
		_gcvt( (double)num, 16, dst->data );
#else
		sprintf( dst->data, "%.16g", num);
#endif

		tmp_len = strlen( dst->data );				/* fake len */

		/* skip the dot at end if any */
		if( tmp_len > 0 )
		{
			if( dst->data[tmp_len-1] == '.' )
			{
				dst->data[tmp_len-1] = '\0';
				--tmp_len;
			}
		}
		fb_hStrSetLength( dst, tmp_len );
	}
	else
		dst = &fb_strNullDesc;

	FB_STRUNLOCK();

	return dst;
}



