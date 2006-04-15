/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2006 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and
 *  the FreeBASIC development team.
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

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
FBCALL void *fb_StrAssign ( void *dst, int dst_size, void *src, int src_size, int fillrem )
{
	FBSTRING 	*dstr;
	char 		*src_ptr;
	int 		src_len, dst_len;

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
			fb_StrDelete_NoLock( dstr );
		}
		else
		{
			/* if src is a temp, just copy the descriptor */
			if( (src_size == -1) && FB_ISTEMP(src) )
			{
				fb_StrDelete_NoLock( dstr );

				dstr->data = src_ptr;
				dstr->len  = src_len;
				dstr->size = ((FBSTRING *)src)->size;

				((FBSTRING *)src)->data = NULL;
				((FBSTRING *)src)->len  = 0;
				((FBSTRING *)src)->size = 0;

				fb_hStrDelTempDesc( (FBSTRING *)src );

				FB_STRUNLOCK();

				return dst;
			}

        	/* else, realloc dst if needed and copy src */
        	dst_len = FB_STRSIZE( dst );

			if( dst_len != src_len )
				fb_hStrRealloc_NoLock( dstr, src_len, FB_FALSE );

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
		if( fillrem != 0 )
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



