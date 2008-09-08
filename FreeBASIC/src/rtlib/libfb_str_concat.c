/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2008 The FreeBASIC development team.
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
 * str_concat.c -- string concatenation function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
static __inline__ void fb_hStrConcat
	(
		char *dst,
		const char *str1,
		int len1,
		const char *str2,
		int len2
	)
{
    dst = FB_MEMCPYX( dst, str1, len1 );
    dst = FB_MEMCPYX( dst, str2, len2 );
	*dst = '\0';
}

/*:::::*/
FBCALL FBSTRING *fb_StrConcat
	(
		FBSTRING *dst,
		void *str1,
		int str1_size,
		void *str2,
		int str2_size
	)
{
	const char *str1_ptr, *str2_ptr;
	int str1_len, str2_len;

	FB_STRSETUP_FIX( str1, str1_size, str1_ptr, str1_len );

	FB_STRSETUP_FIX( str2, str2_size, str2_ptr, str2_len );

	/* NULL? */
	if( str1_len+str2_len == 0 )
	{
		fb_StrDelete( dst );
	}
	else
	{
		/* alloc temp string */
		dst = fb_hStrAllocTemp( dst, str1_len+str2_len );
		DBG_ASSERT( dst );

		/* do the concatenation */
		fb_hStrConcat( dst->data, str1_ptr, str1_len, str2_ptr, str2_len );
	}

	FB_STRLOCK();

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp_NoLock( (FBSTRING *)str2 );

	FB_STRUNLOCK();

	return dst;
}

