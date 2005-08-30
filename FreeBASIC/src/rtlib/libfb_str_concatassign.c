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
 * str_concatassign.c -- string concat and assigning (s = s + expr) function
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL void *fb_StrConcatAssign ( void *dst, int dst_size, void *src, int src_size, int fillrem )
{
	FBSTRING 	*dstr;
	char 		*src_ptr;
	int 		src_len, dst_len;

	FB_STRLOCK();

	if( dst == NULL )
	{
		/* delete temp? */
		if( src_size == -1 )
			fb_hStrDelTemp_NoLock( (FBSTRING *)src );

		FB_STRUNLOCK();

		return dst;
	}

	/* src */
	FB_STRSETUP_FIX( src, src_size, src_ptr, src_len );

	/* not NULL? */
	if( src_len > 0 )
	{
		/* is dst var-len? */
		if( dst_size == -1 )
		{
        	dstr = (FBSTRING *)dst;
        	dst_len = FB_STRSIZE( dst );

			fb_hStrRealloc_NoLock( dstr, dst_len+src_len, FB_TRUE );

			fb_hStrCopy( &dstr->data[dst_len], src_ptr, src_len );
		}
		else
		{
			dst_len = strlen( (char *)dst );

			/* don't check byte ptr's */
			if( dst_size > 0 )
			{
				--dst_size;							/* less the null-term */

				if( src_len > dst_size - dst_len )
					src_len = dst_size - dst_len;
			}

			fb_hStrCopy( &(((char *)dst)[dst_len]), src_ptr, src_len );

			/* don't check byte ptr's */
			if( (fillrem != 0) && (dst_size > 0) )
			{
				/* fill reminder with null's */
				dst_size -= (dst_len + src_len);
				if( dst_size > 0 )
					memset( &(((char *)dst)[dst_len+src_len]), 0, dst_size );
			}
		}
	}


	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)src );

	FB_STRUNLOCK();

	return dst;
}
