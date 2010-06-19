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
 * array_erasestr.c -- ERASE for dynamic arrays of var-len strings
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"

/*:::::*/
void fb_hArrayDtorStr
	(
		FBARRAY *array,
		FB_DEFCTOR dtor,
		int base_idx
	)
{
	int	elements, i;
	FBARRAYDIM *dim;
	FBSTRING *this_;

    dim = &array->dimTB[0];
    elements = dim->elements - base_idx;
    ++dim;

    for( i = 1; i < array->dimensions; i++, dim++ )
    	elements *= dim->elements;

	/* call dtors in the inverse order */
	this_ = (FBSTRING *)array->ptr + (base_idx + (elements-1));

	while( elements > 0 )
	{
		if( this_->data != NULL )
			fb_StrDelete( this_ );
		--this_;
		--elements;
	}
}

/*:::::*/
FBCALL void fb_ArrayStrErase
	(
		FBARRAY *array
	)
{
    if( array->ptr != NULL )
    	fb_hArrayDtorStr( array, NULL, 0 );
}

