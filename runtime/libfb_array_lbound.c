/*
 * array_lbound.c -- lbound function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

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


