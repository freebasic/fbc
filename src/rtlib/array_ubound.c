/* ubound function */

#include "fb.h"

/*:::::*/
FBCALL int fb_ArrayUBound
	( 
		FBARRAY *array, 
		int dimension 
	)
{
	if( dimension > 0 )
		--dimension;

    return array->dimTB[dimension].ubound;
}
