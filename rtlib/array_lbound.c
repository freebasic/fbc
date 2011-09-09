/* lbound function */

#include "fb.h"

/*:::::*/
FBCALL int fb_ArrayLBound
	( 
		FBARRAY *array, 
		int dimension 
	)
{
	if( dimension > 0 )
		--dimension;

    return array->dimTB[dimension].lbound;
}
