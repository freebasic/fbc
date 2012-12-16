/* ubound function */

#include "fb.h"

FBCALL int fb_ArrayUBound( FBARRAY *array, int dimension )
{
	if( dimension > 0 )
		--dimension;

	if( (dimension < 0) || (dimension >= array->dimensions) ) {
		return 0;
	}

	return array->dimTB[dimension].ubound;
}
