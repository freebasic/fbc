/* ubound function */

#include "fb.h"

FBCALL ssize_t fb_ArrayUBound( FBARRAY *array, ssize_t dimension )
{
	/* given dimension is 1-based */
	dimension -= 1;

	/* out-of-bound dimension? */
	if( (dimension < 0) || (dimension >= (ssize_t)array->dimensions) ) {
		/* ubound( a, 0 ) returns the array's dimension count.
		   Any other out-of-bound dimension value returns -1.
		   (see also fb_ArrayLBound()) */
		return dimension == -1 ? (ssize_t)array->dimensions : -1;
	}

	return array->dimTB[dimension].ubound;
}
