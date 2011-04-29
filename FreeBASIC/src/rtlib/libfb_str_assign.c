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
 * str_assign.c -- string assigning function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL void *fb_StrAssignEx
	(
		void *dst,
		int dst_size,
		void *src,
		int src_size,
		int fill_rem,
		int is_init
	)
{
	FBSTRING *dstr;
	const char *src_ptr;
	int src_len;

	FB_STRLOCK();

	if( dst == NULL )
	{
		if( src_size == -1 )
			fb_hStrDelTemp_NoLock( (FBSTRING *)src );

		FB_STRUNLOCK();

		return dst;
	}

	/* src */
	FB_STRSETUP_FIX( src, src_size, src_ptr, src_len );

	/* is dst var-len? */
	if( dst_size == -1 )
	{
        dstr = (FBSTRING *)dst;

		/* src NULL? */
		if( src_len == 0 )
		{
			if( is_init == FB_FALSE ) 
			{
				fb_StrDelete( dstr );
			}
			else
			{
				dstr->data = NULL;
				dstr->len = 0;
				dstr->size = 0;
			}
		}
		else
		{
			/* if src is a temp, just copy the descriptor */
			if( (src_size == -1) && FB_ISTEMP(src) )
			{
				if( is_init == FB_FALSE ) 
					fb_StrDelete( dstr );

				dstr->data = (char *)src_ptr;
				dstr->len = src_len;
				dstr->size = ((FBSTRING *)src)->size;

				((FBSTRING *)src)->data = NULL;
				((FBSTRING *)src)->len = 0;
				((FBSTRING *)src)->size = 0;

				fb_hStrDelTempDesc( (FBSTRING *)src );

				FB_STRUNLOCK();

				return dst;
			}

        	/* else, realloc dst if needed and copy src */
        	if( is_init == FB_FALSE ) 
        	{
				if( FB_STRSIZE( dst ) != src_len )
					fb_hStrRealloc( dstr, src_len, FB_FALSE );
        	}
        	else
        	{
				fb_hStrAlloc( dstr, src_len );
        	}

			fb_hStrCopy( dstr->data, src_ptr, src_len );
		}
	}
	/* fixed-len or zstring.. */
	else
	{
		/* src NULL? */
		if( src_len == 0 )
		{
			*(char *)dst = '\0';
		}
		else
		{
			/* byte ptr? as in C, assume dst is large enough */
			if( dst_size == 0 )
				dst_size = src_len;
			else
			{
				--dst_size; 						/* less the null-term */
				if( dst_size < src_len )
					src_len = dst_size;
			}

			fb_hStrCopy( (char *)dst, src_ptr, src_len );
		}

		/* fill reminder with null's */
		if( fill_rem != 0 )
		{
			dst_size -= src_len;
			if( dst_size > 0 )
				memset( &(((char *)dst)[src_len]), 0, dst_size );
		}
	}


	/* delete temp? */
	if( src_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)src );

	FB_STRUNLOCK();

	return dst;
}

/*:::::*/
FBCALL void *fb_StrAssign
	(
		void *dst,
		int dst_size,
		void *src,
		int src_size,
		int fill_rem
	)
{
	return fb_StrAssignEx( dst, dst_size, src, src_size, fill_rem, FB_FALSE );
}

/*:::::*/
FBCALL void *fb_StrInit
	(
		void *dst,
		int dst_size,
		void *src,
		int src_size,
		int fill_rem
	)
{
	return fb_StrAssignEx( dst, dst_size, src, src_size, fill_rem, FB_TRUE );
}



