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
 * strw_trim.c -- trimw$ function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"


/*:::::*/
FBCALL FB_WCHAR *fb_wStrTrim ( FB_WCHAR *src )
{
	FB_WCHAR *dst, *p;
	int chars;

	if( src == NULL )
		return NULL;

	chars = fb_wstr_Len( src );
	if( chars <= 0 )
		return NULL;

	p = fb_wstr_SkipCharRev( src, chars, 32 );
	chars = fb_wstr_CalcDiff( src, p ) + 1;
	if( chars <= 0 )
		return NULL;

	p = fb_wstr_SkipChar( src, chars, 32 );
	chars -= fb_wstr_CalcDiff( src, p );
	if( chars <= 0 )
		return NULL;

	/* alloc temp string */
    dst = fb_wstr_AllocTemp( chars );
	if( dst != NULL )
	{
		/* simple copy */
		fb_wstr_Copy( dst, p, chars );
	}

	return dst;
}




