/* ERASE function for dynamic arrays of objects */

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
