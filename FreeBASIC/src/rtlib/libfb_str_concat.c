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
 * str_concat.c -- string concatenation function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
static void fb_hStrConcat( char *dst, const char *str1, int len1, const char *str2, int len2 )
{
    dst = FB_MEMCPYX( dst, str1, len1 );
    dst = FB_MEMCPYX( dst, str2, len2 );
	*dst = '\0';
}

/*:::::*/
FBCALL FBSTRING *fb_StrConcat ( FBSTRING *dst, void *str1, int str1_size, void *str2, int str2_size )
{
	char 	*str1_ptr, *str2_ptr;
	int 	str1_len, str2_len;

	FB_STRLOCK();

	FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );

	FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

	/* NULL? */
	if( str1_len+str2_len == 0 )
	{
		fb_StrDelete_NoLock( dst );
	}
	else
	{
		/* alloc temp string */
        if( !fb_hStrAllocTemp_NoLock( dst, str1_len+str2_len ) )
            DBG_ASSERT( FALSE );

		/* do the concatenation */
		fb_hStrConcat( dst->data, str1_ptr, str1_len, str2_ptr, str2_len );
	}

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str2 );

	FB_STRUNLOCK();

	return dst;
}

