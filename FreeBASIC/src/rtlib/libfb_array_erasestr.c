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
 * array_erasestr.c -- ERASE for dynamic arrays of var-len strings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <malloc.h>
#include "fb.h"

/*:::::*/
int fb_hArrayFreeVarLenStrs( FBARRAY *array, int base )
{
	int			i;
	int 		elements;
	FBSTRING 	*p;
	FBARRAYDIM	*d;

	p = (FBSTRING *)array->ptr;
	if (p == NULL)
		return FB_FALSE;
	p += base;

    d = &array->dimTB[0];
    elements = d->elements - base;
    ++d;
    for( i = 1; i < array->dimensions; i++, d++ )
    	elements *= d->elements;

	while( elements != 0 )
	{
		--elements;
		if( p->data != NULL )
			fb_StrDelete( p );
		++p;
	}

	return FB_TRUE;
}

/*:::::*/
FBCALL void fb_ArrayStrErase( FBARRAY *array )
{
	FB_LOCK();

    if( array->ptr != NULL )
    	fb_hArrayFreeVarLenStrs( array, 0 );

    FB_UNLOCK();
}

