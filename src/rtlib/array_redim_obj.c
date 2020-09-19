/* redim function */

#include "fb.h"

int fb_ArrayRedimObj
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

	/* free old */
	if( dtor )
		fb_ArrayDestructObj( array, dtor );
	fb_ArrayErase( array );

	va_start( ap, dimensions );
	/* Have to assume doclear=TRUE, because we have no doclear parameter here,
	   and don't know what to do, so better be safe. */
	res = fb_hArrayAlloc( array, element_len, TRUE, ctor, dimensions, ap );
	va_end( ap );

	return res;
}
