/*!!!REMOVEME!!!*/
/* descriptor reset, for dynamic local arrays */

#include "fb.h"

/*:::::*/
FBCALL void fb_ArrayResetDesc
	( 
		FBARRAY *array 
	)
{
    int	i;
    FBARRAYDIM *dim;

    dim = &array->dimTB[0];

    for( i = 0; i < array->dimensions; i++ )
    {
    	dim->elements = 0;
    	dim->lbound = 0;
    	dim->ubound = 0;
    	++dim;
    }

    array->ptr = NULL;

    FB_ARRAY_SETDESC( array, array->element_len, 0, 0, 0 );
}

