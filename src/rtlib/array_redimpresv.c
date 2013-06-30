/* redim preserve function */

#include "fb.h"

fbint fb_hArrayRealloc
	(
		FBARRAY *array,
		fbint element_len,
		fbint doclear,
		FB_DEFCTOR ctor,
		FB_DTORMULT dtor_mult,
		FB_DEFCTOR dtor,
		fbint dimensions,
		va_list ap
	)
{
	fbint i, elements, diff, size, new_lb, objects;
    FBARRAYDIM *dim;
	fbint lbTB[FB_MAXDIMENSIONS];
	fbint ubTB[FB_MAXDIMENSIONS];
    const char *this_;
    
    /* load bounds */
    for( i = 0; i < dimensions; i++ )
    {
		lbTB[i] = va_arg( ap, fbint );
		ubTB[i] = va_arg( ap, fbint );

        if( lbTB[i] > ubTB[i] )
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	/* shrinking the array? free unused elements */
    if( dtor_mult != NULL )
    {
		new_lb = (ubTB[0] - lbTB[0]) + 1;
    	if( new_lb < array->dimTB[0].elements )
    	{
        	/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
        	dtor_mult( array, dtor, new_lb );
        }
    }

    /* calc size */
    elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
    diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
    size = elements * element_len;

	/* realloc */
    array->ptr = realloc( array->ptr, size );
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

	/* clear remainder */
    if( size > array->size )
    {
    	this_ = ((const char*)array->ptr) + array->size;
    	
    	if( doclear )            	
        	memset( (void *)this_, 0, size - array->size );
        	
        if( ctor != NULL )
        {
			objects = (size - array->size) / element_len;
			while( objects > 0 )
			{
				/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
				ctor( this_ );
				
				this_ += element_len;
				--objects;
			}
        }
    }

    /* set descriptor */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++, dim++ )
    {
    	dim->elements = (ubTB[i] - lbTB[i]) + 1;
    	dim->lbound = lbTB[i];
    	dim->ubound = ubTB[i];
    }

	FB_ARRAY_SETDESC( array, element_len, dimensions, size, diff );

    return fb_ErrorSetNum( FB_RTERROR_OK );
}

static fbint hRedim
	(
		FBARRAY *array,
		fbint element_len,
		fbint doclear,
		fbint isvarlen,
		fbint dimensions,
		va_list ap
	)
{
	FB_DTORMULT dtor_mult;
	
    /* new? */
    if( array->ptr == NULL )
    	return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
    	
	/* realloc.. */
	if( isvarlen )
		dtor_mult = &fb_hArrayDtorStr;
	else
		dtor_mult = NULL;
	
	return fb_hArrayRealloc( array, element_len, doclear, NULL, dtor_mult, NULL, dimensions, ap );
}

fbint fb_ArrayRedimPresvEx
	(
		FBARRAY *array,
		fbint element_len,
		fbint doclear,
		fbint isvarlen,
		fbint dimensions,
		...
	)
{
	va_list ap;
	fbint res;
	
	va_start( ap, dimensions );
    res = hRedim( array, element_len, doclear, isvarlen, dimensions, ap );
    va_end( ap );
    
    return res;
}

fbint fb_ArrayRedimPresv
	(
		FBARRAY *array,
		fbint element_len,
		fbint isvarlen,
		fbint dimensions,
		...
	)
{
	va_list ap;
	fbint res;
	
	va_start( ap, dimensions );
    res = hRedim( array, element_len, TRUE, isvarlen, dimensions, ap );
    va_end( ap );
    
    return res;
}
