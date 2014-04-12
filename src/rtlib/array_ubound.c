/* ubound function */

#include "fb.h"

/* Returns the ubound of the given dimension, or -1 if the given dimension
   doesn't exist.

   Special case: ubound( a, 0 ) returns the dimension count.

   Note: The dimension count can be set (in the descriptor) even for unallocated
   arrays, as it's fixed and determines the descriptor size. However, currently
   ubound( a, 0 ) will always return 0 for unallocated arrays. */
FBCALL ssize_t fb_ArrayUBound( FBARRAY *array, ssize_t dimension )
{
	/* given dimension is 1-based */
	dimension -= 1;

	/* Querying dimension count? */
	if( dimension == -1 ) {
		if( array->data ) {
			return (ssize_t)array->dimensions;
		}
		return 0;
	}

	/* Querying dimension's ubound. */

	/* unallocated array or out-of-bound dimension? */
	if( (array->data == NULL) ||
	    (dimension < 0) || ((size_t)dimension >= array->dimensions) ) {
		return -1;
	}
	return array->dimTB[dimension].ubound;
}
