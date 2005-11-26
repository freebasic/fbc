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
 * str_rtrimex.c -- enhanced rtrim$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"


/*:::::*/
FBCALL FB_WCHAR *fb_WstrRTrimEx ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
	FB_WCHAR *dst;
	size_t chars, chars_pattern;
	const FB_WCHAR *p = NULL;

	if( src == NULL || pattern == NULL )
		return NULL;

	chars_pattern = fb_wstr_Len( pattern );
	chars = fb_wstr_Len( src );
	if( chars >= chars_pattern )
	{
		if( chars_pattern == 1 )
		{
			p = fb_wstr_SkipCharRev( src, chars, pattern[0] );
			chars = fb_wstr_CalcDiff( src, p ) + 1;
		}
		else if( chars_pattern != 0 )
		{
			size_t test_index = chars - chars_pattern;
			p = src;
			while( chars >= chars_pattern )
			{
				if( wmemcmp( p + test_index, pattern, chars_pattern ) != 0 )
					break;
				test_index -= chars_pattern;
			}
			chars = test_index + chars_pattern;
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

