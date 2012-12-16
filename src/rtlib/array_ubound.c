/* ubound function */

#include "fb.h"

FBCALL int fb_ArrayUBound( FBARRAY *array, int dimension )
{
	dimension -= 1;

	if( (dimension < 0) || (dimension >= array->dimensions) ) {
		return 0;
	}

	return array->dimTB[dimension].ubound;
}
