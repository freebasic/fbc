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
 * str_instr.c -- instr function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include <string.h>
#include "fb.h"


/*:::::*/
FBCALL int fb_StrInstr ( int start, FBSTRING *src, FBSTRING *patt )
{
    int 	r;
    char    *p;

    if( (src != NULL) && (src->data != NULL) && (patt != NULL) && (patt->data != NULL) )
    {
    	if( (start > 0) && (start <= FB_STRSIZE( src )) )
    	{
    		p = strstr( src->data + start-1, patt->data );
    		if( p != NULL )
    			r = (int)(p - src->data) + 1;
    		else
    			r = 0;
    	}
    	else
    		r = 0;
    }
    else
    	r = 0;

	/* del if temp */
	fb_hStrDelTemp( src );

	fb_hStrDelTemp( patt );

	return r;
}
