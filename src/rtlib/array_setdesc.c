/*!!!REMOVEME!!!*/
/* descriptor set, for non-dynamic local arrays */

#include "fb.h"


/*:::::*/
void fb_ArraySetDesc
	( 
		FBARRAY *array, 
		void *ptr, 
		int element_len, 
		int dimensions, 
		... 
	)
{
    va_list ap;
    int	i, elements, diff;
    FBARRAYDIM *dim;
    int	lbTB[FB_MAXDIMENSIONS];
    int	ubTB[FB_MAXDIMENSIONS];

    va_start( ap, dimensions );

    dim = &array->dimTB[0];

    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
    	ubTB[i] = va_arg( ap, int );

    	dim->elements = (ubTB[i] - lbTB[i]) + 1;
    	dim->lbound = lbTB[i];
    	dim->ubound = ubTB[i];
    	++dim;
    }

    va_end( ap );

    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;

    array->ptr = ptr;

    FB_ARRAY_SETDESC( array, element_len, dimensions, elements * element_len, diff );
}

