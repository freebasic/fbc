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
 * strw_convfrom_str.c -- ascii to unicode string convertion function
 *
 * chng: ago/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FB_WCHAR *fb_StrToWstr( const char *src )
{
	FB_WCHAR *dst;
	int chars;

    if( src == NULL )
    	return NULL;

	chars = strlen( src );
    if( chars == 0 )
    	return NULL;

    dst = fb_wstr_AllocTemp( chars );
	if( dst == NULL )
		return NULL;

	fb_wstr_ConvFromA( dst, chars, src );

	return dst;
}

