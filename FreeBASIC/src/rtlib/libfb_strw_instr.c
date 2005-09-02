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
 * strw_instr.c -- instrw function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include "fb_unicode.h"

/*:::::*/
FBCALL int fb_wStrInstr ( int start, FB_WCHAR *src, FB_WCHAR *patt )
{
    int r;
    FB_WCHAR *p;

    if( (src == NULL) || (patt == NULL) )
    	return 0;

    if( (start > 0) && (start <= FB_STRSIZE( src )) )
    {
    	p = fb_wstr_Instr( fb_wstr_OffsetOf( src, start-1 ), patt );
    	if( p != NULL )
    		r = fb_wstr_CalcDiff( src, p ) + 1;
    	else
    		r = 0;
    }
    else
    	r = 0;

	return r;
}
