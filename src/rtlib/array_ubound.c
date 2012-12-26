/* ubound function */

#include "fb.h"

FBCALL int fb_ArrayUBound( FBARRAY *array, int dimension )
{
	dimension -= 1;

	if( (dimension < 0) || (dimension >= array->dimensions) ) {
		/* ubound( a, 0 ) returns the array's dimension count,
		   any other out-of-bound dimension value returns 0,
		   together with lbound() returning 1 for such cases
		   we can detect invalid dimensions */
		return dimension == -1 ? array->dimensions : 0;
	}

	return array->dimTB[dimension].ubound;
}
