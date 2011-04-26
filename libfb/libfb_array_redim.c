/*
 * array_redim.c -- redim function
 *
 * chng: oct/2004 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <stdarg.h>
#include "fb.h"

/*:::::*/
int fb_hArrayAlloc
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		FB_DEFCTOR ctor,
		int dimensions, 
		va_list ap 
	)
{
    int	i, elements, diff, size;
    FBARRAYDIM *dim;
    int	lbTB[FB_MAXDIMENSIONS];
    int	ubTB[FB_MAXDIMENSIONS];

    /* load bounds */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++ )
    {
    	lbTB[i] = va_arg( ap, int );
        ubTB[i] = va_arg( ap, int );

        if( lbTB[i] > ubTB[i] )
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    	dim->elements = (ubTB[i] - lbTB[i]) + 1;
    	dim->lbound = lbTB[i];
    	dim->ubound = ubTB[i];
    	++dim;
    }

    /* calc size */
    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
    size = elements * element_len;

    /* alloc new */
    if( doclear )
    	array->ptr = calloc( size, 1 );
    else
    	array->ptr = malloc( size );
    
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

    /* set descriptor */
    FB_ARRAY_SETDESC( array, element_len, dimensions, size, diff );

   	/* call ctor for each element */
   	if( ctor != NULL )
   	{
		const char *this_ = (const char *)array->ptr;
		while( elements > 0 )
		{
			/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
			ctor( this_ );
			
			this_ += element_len;
			--elements;
		}
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

/*:::::*/
static int hRedim
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		int isvarlen, 
		int dimensions, 
		va_list ap 
	)
{

    /* free old */
    if( array->ptr != NULL )
    {
    	if( isvarlen != 0 )
    		fb_hArrayDtorStr( array, NULL, 0 );
    	
    	free( array->ptr );
    	array->ptr = NULL;
    	array->data = NULL;
    }
    
    return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
}

/*:::::*/
int fb_ArrayRedimEx
	( 
		FBARRAY *array, 
		int element_len, 
		int doclear, 
		int isvarlen, 
		int dimensions, 
		... 
	)
{
	va_list ap;
	int res;
	
	va_start( ap, dimensions );
    res = hRedim( array, element_len, doclear, isvarlen, dimensions, ap );
    va_end( ap );
    
    return res;
}

/*:::::*/
int fb_ArrayRedim
	( 
		FBARRAY *array, 
		int element_len, 
		int isvarlen, 
		int dimensions, 
		... 
	)
{
	va_list ap;
	int res;
	
	va_start( ap, dimensions );
	res = hRedim( array, element_len, TRUE, isvarlen, dimensions, ap );
	va_end( ap );
	
	return res;
}

