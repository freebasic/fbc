/*
 *	libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *	This library is free software; you can redistribute it and/or
 *	modify it under the terms of the GNU Lesser General Public
 *	License as published by the Free Software Foundation; either
 *	version 2.1 of the License, or (at your option) any later version.
 *
 *	This library is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *	Lesser General Public License for more details.
 *
 *	You should have received a copy of the GNU Lesser General Public
 *	License along with this library; if not, write to the Free Software
 *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * wstr_trim.c -- trim$ ANY function for wstrings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"


/*:::::*/
FBCALL FB_WCHAR *fb_WstrTrimAny ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
	FB_WCHAR *dst;
	size_t chars, chars_pattern;

	if( src == NULL || pattern == NULL )
		return NULL;

	chars = 0;
	chars_pattern = fb_wstr_Len( pattern );
	chars = fb_wstr_Len( src );
	while ( chars != 0 )
	{
		size_t i;
		for( i = 0; i != chars_pattern; ++i )
		{
			if( wmemchr( pattern, *src, chars_pattern ) != NULL )
				break;
		}

		if( i == chars_pattern )
			break;

		--chars;
		++src;
	}

	while ( chars != 0 )
	{
		size_t i;
		--chars;
		for( i = 0; i != chars_pattern; ++i )
		{
			if( wmemchr( pattern, src[chars], chars_pattern ) != NULL )
				break;
		}

		if( i == chars_pattern )
		{
			++chars;
			break;
		}
	}

	if( chars == 0 )
		return NULL;

	/* alloc temp string */
	dst = fb_wstr_AllocTemp( chars );
	if( dst != NULL )
		fb_wstr_Copy( dst, src, chars );

	return dst;
}
