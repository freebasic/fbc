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
 * str_concat.c -- string concatenation function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

/*:::::*/
static void fb_hStrConcat( char *dst, char *str1, int len1, char *str2, int len2 )
{
#ifndef TARGET_X86

	if( str1 != NULL )
		while( --len1 >= 0 )
			*dst++ = *str1++;

	if( str2 != NULL )
		while( --len2 >= 0 )
			*dst++ = *str2++;

#else

	if( (str1 != NULL) && (len1 > 0) )
	{
		asm (
			"pushl %%ecx\n"
			"shrl $2,%%ecx\n"
			"rep\n"
			"movsd\n"
			"popl %%ecx\n"
			"andl $3,%%ecx\n"
			"rep\n"
			"movsb"
			: /* */
			: "c" (len1), "S" (str1), "D" (dst) );
	}

	if( (str2 != NULL) && (len2 > 0) )
	{
		asm (
			"pushl %%ecx\n"
			"shrl $2,%%ecx\n"
			"rep\n"
			"movsd\n"
			"popl %%ecx\n"
			"andl $3,%%ecx\n"
			"rep\n"
			"movsb"
			: /* */
			: "c" (len2), "S" (str2), "D" (dst) );
	}

#endif

	*dst = '\0';

}

/*:::::*/
FBCALL FBSTRING *fb_StrConcat ( FBSTRING *dst, void *str1, int str1_size, void *str2, int str2_size )
{
	char 	*str1_ptr, *str2_ptr;
	int 	str1_len, str2_len;

	FB_STRLOCK();

	FB_STRSETUP( str1, str1_size, str1_ptr, str1_len )

	FB_STRSETUP( str2, str2_size, str2_ptr, str2_len )

	/* NULL? */
	if( str1_len+str2_len == 0 )
	{
#ifdef MULTITHREADED
		fb_hStrDeleteLocked( dst );
#else
		fb_StrDelete( dst );
#endif
	}
	else
	{
		/* alloc temp string */
		fb_hStrAllocTemp( dst, str1_len+str2_len );

		/* do the concatenation */
		fb_hStrConcat( dst->data, str1_ptr, str1_len, str2_ptr, str2_len );
	}

	/* delete temps? */
	if( str1_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str1 );
	if( str2_size == -1 )
		fb_hStrDelTemp( (FBSTRING *)str2 );

	FB_STRUNLOCK();

	return dst;
}

