/* ERASE for dynamic arrays of objects: destruct elements and free the array */

#include "fb.h"

void fb_hArrayDtorObj( FBARRAY *array, FB_DEFCTOR dtor, int base_idx )
{
	int	elements, element_len, i;
	FBARRAYDIM *dim;
	const char *this_;

	if( array->ptr == NULL )
		return;

    dim = &array->dimTB[0];
    elements = dim->elements - base_idx;
    ++dim;

    for( i = 1; i < array->dimensions; i++, dim++ )
	   	elements *= dim->elements;

	/* call dtors in the inverse order */
	element_len = array->element_len;
	this_ = (const char *)array->ptr + ((base_idx + (elements-1)) * element_len);

	while( elements > 0 ) {
		/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
		dtor( this_ );
		this_ -= element_len;
		--elements;
	}
}

FBCALL void fb_ArrayDestructObj( FBARRAY *array, FB_DEFCTOR dtor )
{
	fb_hArrayDtorObj( array, dtor, 0 );
}
