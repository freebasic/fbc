/* lbound function */

#include "fb.h"

FBCALL int fb_ArrayLBound( FBARRAY *array, int dimension )
{
	dimension -= 1;

	if( (dimension < 0) || (dimension >= array->dimensions) ) {
		/* lbound( a, 0 ) returns the lower bound of the array's
		   dimTB, always 1. Together with ubound returning the
		   dimension count or 0 for other invalid dimensions we can
		   detect empty arrays etc. (because lbound > ubound) */
		return 1;
	}

	return array->dimTB[dimension].lbound;
}
