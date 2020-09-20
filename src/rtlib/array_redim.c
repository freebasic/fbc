/* redim function */

#include "fb.h"

int fb_hArrayAlloc
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		FB_DEFCTOR ctor,
		size_t dimensions,
		va_list ap
	)
{
	size_t i, elements, size;
	ssize_t diff;
	FBARRAYDIM *dim;
	ssize_t lbTB[FB_MAXDIMENSIONS];
	ssize_t ubTB[FB_MAXDIMENSIONS];

	/* fixed length? */

	if( array->flags & FBARRAY_FLAGS_FIXED_LEN )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* Must take care with the descriptor's maximum dimensions, because fbc
	   may allocate a smaller descriptor (with room only for some
	   dimensions, but not necessarily all of FB_MAXARRAYDIMS). Thus it's
	   not safe to increase the dimension count of a descriptor.

	   Of course it's not very useful to change the array's dimension count
	   in the first place, because FB's array access syntax depends on the
	   dimension count, and fbc disallows changing it at compile-time in
	   most cases.

	   The situation where fbc can't know the exact dimensions is with
	   <dim array()> where there's no dimension count given in the
	   declaration. If fbc can't figure out the dimension count later during
	   the compilation, then it has to allocate a descriptor with room for
	   FB_MAXARRAYDIMS and initialize its FBARRAY.dimension field to 0.
	   Then, if we see the 0 here, we know that there's room for
	   FB_MAXARRAYDIMS, and can initialize the descriptor for its first use.
	   Once this initial dimension count has been set, it can't be changed
	   anymore, because the descriptor from then on looks like it only has
	   room for that first-used amount of dimensions. Any unused dimensions
	   will be wasted memory of course.

	   Thus overall it's best to disallow changing the dimension count at
	   runtime completely, except for the first-use case where fbc couldn't
	   figure out the dimensions at compile-time. */
	if( (dimensions != array->dimensions) && (array->dimensions != 0) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    /* load bounds */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++ )
    {
		lbTB[i] = va_arg( ap, ssize_t );
		ubTB[i] = va_arg( ap, ssize_t );

        if( lbTB[i] > ubTB[i] )
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    	dim->elements = (ubTB[i] - lbTB[i]) + 1;
    	dim->lbound = lbTB[i];
    	dim->ubound = ubTB[i];
    	++dim;
    }

    /* calc size */
    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
    size = elements * element_len;

	/* Allocte new buffer */
	/* Clearing is not needed if not requested, or if ctors will be called
	   (ctors take care of clearing themselves) */
	if( doclear && (ctor == NULL) )
		array->ptr = calloc( size, 1 );
	else
		array->ptr = malloc( size );
    
    if( array->ptr == NULL )
        return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

    /* call ctor for each element */
    if( ctor ) {
        unsigned char *this_ = array->ptr;
        while( elements > 0 )
        {
            /* !!!FIXME!!! check exceptions (only if rewritten in C++) */
            ctor( this_ );

            this_ += element_len;
            --elements;
        }
    }

	DBG_ASSERT( array->element_len == element_len || array->element_len == 0 );
	DBG_ASSERT( array->dimensions == dimensions || array->dimensions == 0 );

	array->data = ((unsigned char *)array->ptr) + diff;
	array->size = size;
	array->element_len = element_len;
	array->dimensions = dimensions;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

static int hRedim
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		int isvarlen,
		size_t dimensions,
		va_list ap
	)
{
	/* free old */
	if( isvarlen ) {
		fb_ArrayStrErase( array );
	} else {
		fb_ArrayErase( array );
	}

    return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
}

int fb_ArrayRedimEx
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		int isvarlen,
		size_t dimensions,
		...
	)
{
	va_list ap;
	int res;

	va_start( ap, dimensions );
    res = hRedim( array, element_len, doclear, isvarlen, dimensions, ap );
    va_end( ap );

    return res;
}
