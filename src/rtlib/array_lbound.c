/* lbound function */

#include "fb.h"

FBCALL ssize_t fb_ArrayLBound( FBARRAY *array, ssize_t dimension )
{
	/* given dimension is 1-based */
	dimension -= 1;

	/* out-of-bound dimension? */
	if( (dimension < 0) || (dimension >= array->dimensions) ) {
		/*
		 * lbound( a, 0 ) returns the lower bound of the array's dimTB,
		 * always 1. Any other out-of-bound dimension value returns 0.
		 *
		 * Together with ubound returning the dimension count or -1 for
		 * these cases respectively, we can check the dimension count
		 * and detect empty arrays.
		 *
		 * Using lbound=0 and ubound=-1 for empty arrays is good because
		 * it means that lbound > ubound, which is normally invalid,
		 * and lbound staying 0 allows checks such as
		 *    @array(lbound(array)) <> NULL
		 * to keep working.
		 */
		return dimension == -1 ? 1 : 0;
	}

	return array->dimTB[dimension].lbound;
}
