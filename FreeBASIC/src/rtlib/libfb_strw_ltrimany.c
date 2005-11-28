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
 * strw_ltrimany.c -- ltrimw$ ANY function
 *
 * chng: nov/2005 written [mjs]
 *
 */

#include <malloc.h>
#include "fb.h"


/*:::::*/
FBCALL FB_WCHAR *fb_WstrLTrimAny ( const FB_WCHAR *src, const FB_WCHAR *pattern )
{
    const FB_WCHAR *pachText;
	FB_WCHAR 	*dst;
	size_t 		len;

    if( src == NULL ) {
        return NULL;
    }

	len = fb_wstr_Len( src );
    {
        size_t len_pattern = fb_wstr_Len( pattern );
        pachText = src;
		while ( len != 0 )
        {
            size_t i;
            for( i=0; i!=len_pattern; ++i ) {
                if( wcschr( pattern, *pachText )!=NULL ) {
                    break;
                }
            }
            if( i==len_pattern ) {
                break;
            }
            --len;
            ++pachText;
		}
	}

	if( len > 0 )
	{
		/* alloc temp string */
        dst = fb_wstr_AllocTemp( len );
		if( dst != NULL )
		{
			/* simple copy */
			fb_wstr_Copy( dst, pachText, len );
		}
		else
			dst = NULL;
    }
	else
		dst = NULL;

	return dst;
}

