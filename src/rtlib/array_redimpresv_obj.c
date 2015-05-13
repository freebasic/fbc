/* redim preserve function */

#include "fb.h"

int fb_ArrayRedimPresvObj
	(
		FBARRAY *array,
		size_t element_len,
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor,
		size_t dimensions,
		...
	)
{
	va_list ap;
	int res;

	va_start( ap, dimensions );

	/* Have to assume doclear=TRUE, because we have no doclear parameter here,
	   and don't know what to do, so better be safe. */

	/* new? */
	if( array->ptr == NULL ) {
		res = fb_hArrayAlloc( array, element_len, TRUE, ctor, dimensions, ap );
	} else {
		/* realloc.. */
		FB_DTORMULT dtor_mult = (dtor != NULL? &fb_hArrayDtorObj : NULL );
		res = fb_hArrayRealloc( array, element_len, TRUE, ctor, dtor_mult, dtor, dimensions, ap );
	}

    va_end( ap );
    
    return res;
}
