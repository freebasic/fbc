/* redim function */

#include "fb.h"

fbint fb_hArrayAlloc
	(
		FBARRAY *array,
		fbint element_len,
		fbint doclear,
		FB_DEFCTOR ctor,
		fbint dimensions,
		va_list ap
	)
{
	fbint i, elements, diff, size;
    FBARRAYDIM *dim;
	fbint lbTB[FB_MAXDIMENSIONS];
	fbint ubTB[FB_MAXDIMENSIONS];

    /* load bounds */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++ )
    {
		lbTB[i] = va_arg( ap, fbint );
		ubTB[i] = va_arg( ap, fbint );

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

	/* free old */
	fb_ArrayErase( array, isvarlen );

    return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
}

fbint fb_ArrayRedimEx
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

fbint fb_ArrayRedim
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
