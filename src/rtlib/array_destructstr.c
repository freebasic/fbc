/* ERASE for dynamic arrays of var-len strings */

#include "fb.h"

void fb_hArrayDtorStr( FBARRAY *array, FB_DEFCTOR dtor, size_t base_idx )
{
    size_t i;
	ssize_t elements;
	FBARRAYDIM *dim;
	FBSTRING *this_;

	if( array->ptr == NULL )
		return;

    dim = &array->dimTB[0];
    elements = dim->elements - base_idx;
    ++dim;

    for( i = 1; i < array->dimensions; i++, dim++ )
        elements *= dim->elements;

    /* call dtors in the inverse order */
    this_ = (FBSTRING *)array->ptr + (base_idx + (elements-1));

	while( elements > 0 ) {
		if( this_->data != NULL )
			fb_StrDelete( this_ );
		--this_;
		--elements;
	}
}

FBCALL void fb_ArrayDestructStr( FBARRAY *array )
{
	fb_hArrayDtorStr( array, NULL, 0 );
}
