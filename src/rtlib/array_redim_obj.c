/* redim function */

#include "fb.h"

fbinteger fb_ArrayRedimObj
	(
		FBARRAY *array,
		fbinteger element_len,
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor,
		fbinteger dimensions,
		...
	)
{
	va_list ap;
	fbinteger res;

	/* free old */
	if( dtor )
		fb_ArrayDestructObj( array, dtor );
	fb_ArrayErase( array, 0 );

	va_start( ap, dimensions );
	res = fb_hArrayAlloc( array, element_len, FB_FALSE, ctor, dimensions, ap );
	va_end( ap );

	return res;
}
