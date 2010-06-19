/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * array_erase_obj.c -- ERASE function for dynamic arrays of objects
 *
 * chng: sep/2006 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
void fb_hArrayCtorObj
	(
		FBARRAY *array,
		FB_DEFCTOR ctor,
		int base_idx
	)
{
	int	elements, element_len, i;
	FBARRAYDIM *dim;
	const char *this_;

    dim = &array->dimTB[0];
    elements = dim->elements - base_idx;
    ++dim;

    for( i = 1; i < array->dimensions; i++, dim++ )
	   	elements *= dim->elements;

	/* call ctors */
	element_len = array->element_len;
	this_ = (const char *)array->ptr;

	while( elements > 0 )
	{
		/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
		ctor( this_ );

		this_ += element_len;
		--elements;
	}
}

/*:::::*/
void fb_hArrayDtorObj
	(
		FBARRAY *array,
		FB_DEFCTOR dtor,
		int base_idx
	)
{
	int	elements, element_len, i;
	FBARRAYDIM *dim;
	const char *this_;

    dim = &array->dimTB[0];
    elements = dim->elements - base_idx;
    ++dim;

    for( i = 1; i < array->dimensions; i++, dim++ )
	   	elements *= dim->elements;

	/* call dtors in the inverse order */
	element_len = array->element_len;
	this_ = (const char *)array->ptr + ((base_idx + (elements-1)) * element_len);

	while( elements > 0 )
	{
		/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
		dtor( this_ );

		this_ -= element_len;
		--elements;
	}
}

/*:::::*/
FBCALL int fb_ArrayEraseObj
	(
		FBARRAY *array,
		FB_DEFCTOR dtor
	)
{
    /* not an error, dynamic arrays declared as static could be never
       allocated, but the dtor wrapper will be invoked anyways */
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OK );

    fb_hArrayDtorObj( array, dtor, 0 );

    free( array->ptr );
    fb_ArrayResetDesc( array );

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
