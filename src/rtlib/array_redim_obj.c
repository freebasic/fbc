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
	fb_ArrayErase( array, 0 );

	va_start( ap, dimensions );
	res = fb_hArrayAlloc( array, element_len, FB_FALSE, ctor, dimensions, ap );
	va_end( ap );

	return res;
}
