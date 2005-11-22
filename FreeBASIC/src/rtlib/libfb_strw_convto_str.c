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
 * strw_convto_str.c -- unicode to ascii string convertion function
 *
 * chng: ago/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_WstrToStr( const FB_WCHAR *src )
{
	FBSTRING *dst;
	int chars;

    if( src == NULL )
    	return &fb_strNullDesc;

	chars = fb_wstr_Len( src );
    if( chars == 0 )
    	return &fb_strNullDesc;

    dst = fb_hStrAllocTemp( NULL, chars );
	if( dst == NULL )
		return &fb_strNullDesc;

	fb_wstr_ConvToA( dst->data, src, chars );

	return dst;
}

