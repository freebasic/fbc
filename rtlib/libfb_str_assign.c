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
 * str_assign.c -- string assigning function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_StrAssign ( void *dst, int dst_size, void *src, int src_size )
{
	FBSTRING 	*dstr;
	char 		*src_ptr;
	int 		src_len, dst_len;

	if( (dst == NULL) || (src == NULL) )
		return;

	/* src */
	FB_STRSETUP( src, src_size, src_ptr, src_len )

	/* is dst var-len? */
	if( dst_size == -1 )
	{
        dstr = (FBSTRING *)dst;

		/* if src is a temp, just copy the descriptor */
		if( (src_size == -1) && FB_ISTEMP(src) )
		{
			fb_StrDelete( dstr );

			dstr->data = src_ptr;
			dstr->len  = src_len;

			((FBSTRING *)src)->data = NULL;
			((FBSTRING *)src)->len  = 0;

			fb_hStrDelTempDesc( (FBSTRING *)src );

			return;
		}

        /* else, realloc dst if needed and copy src */
        dst_len = FB_STRSIZE( dst );

		/* NULL? */
		if( src_len == 0 )
		{
			fb_StrDelete( dstr );
			dstr->data = &fb_strNull;
		}
		else
		{
			if( dst_len != src_len )
				fb_hStrRealloc( dstr, src_len );

			fb_hStrCopy( dstr->data, src_ptr, src_len );
		}
	}
	else
	{
		/* byte ptr? */
		if( dst_size == 0 )
			dst_size = strlen( (char *)dst );

		if( dst_size < src_len )
			src_len = dst_size;

		fb_hStrCopy( (char *)dst, src_ptr, src_len );

		/* fill reminder with null's */
		dst_size -= src_len;
		if( dst_size > 0 )
			memset( &(((char *)dst)[src_len]), 0, dst_size );
	}


	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)src );

}



