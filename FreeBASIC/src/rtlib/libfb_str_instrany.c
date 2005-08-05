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
 * str_instr.c -- instr function
 *
 * chng: oct/2004 written [v1ctor]
 * chng: aug/2005 added boyer-moore and quirck search algorithms [mjs]
 *                added special search case with pattern length = 1 [mjs]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"

FBCALL int fb_StrInstrAny ( int start, FBSTRING *src, FBSTRING *patt )
{
    int r;

    FB_STRLOCK();

    if( (src == NULL) || (src->data == NULL) || (patt == NULL) || (patt->data == NULL) ) {
        r = 0;
    } else {
        size_t size_src = FB_STRSIZE(src);
        size_t size_patt = FB_STRSIZE(patt);
        if( ((start < 1) || (start > size_src)) ) {
            r = 0;
        } else if( size_patt==0 && size_src!=0 ) {
            r = start;
        } else {
            size_t i, found, search_len = size_src - start + 1;
            const char *pachText = src->data + start - 1;
            r = search_len;
            for( i=0; i!=size_patt; ++i ) {
                const char *pszEnd = FB_MEMCHR( pachText, patt->data[i], r );
                if( pszEnd!=NULL ) {
                    found = pszEnd - pachText;
                    if( found < r )
                        r = found;
                }
            }
            if( r==search_len ) {
                r = 0;
            } else {
                r += start;
            }
        }
    }

	/* del if temp */
	fb_hStrDelTemp( src );
	fb_hStrDelTemp( patt );

    FB_STRUNLOCK();

    return r;
}
