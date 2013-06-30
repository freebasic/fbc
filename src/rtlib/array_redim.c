/* redim function */

#include "fb.h"

fbinteger fb_hArrayAlloc
	(
		FBARRAY *array,
		fbinteger element_len,
		fbinteger doclear,
		FB_DEFCTOR ctor,
		fbinteger dimensions,
		va_list ap
	)
{
	fbinteger i, elements, diff, size;
    FBARRAYDIM *dim;
	fbinteger lbTB[FB_MAXDIMENSIONS];
	fbinteger ubTB[FB_MAXDIMENSIONS];

    /* load bounds */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++ )
    {
		lbTB[i] = va_arg( ap, fbinteger );
		ubTB[i] = va_arg( ap, fbinteger );

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

static fbinteger hRedim
	(
		FBARRAY *array,
		fbinteger element_len,
		fbinteger doclear,
		fbinteger isvarlen,
		fbinteger dimensions,
		va_list ap
	)
{

	/* free old */
	fb_ArrayErase( array, isvarlen );

    return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
}

fbinteger fb_ArrayRedimEx
	(
		FBARRAY *array,
		fbinteger element_len,
		fbinteger doclear,
		fbinteger isvarlen,
		fbinteger dimensions,
		...
	)
{
	va_list ap;
	fbinteger res;

	va_start( ap, dimensions );
    res = hRedim( array, element_len, doclear, isvarlen, dimensions, ap );
    va_end( ap );

    return res;
}

fbinteger fb_ArrayRedim
	(
		FBARRAY *array,
		fbinteger element_len,
		fbinteger isvarlen,
		fbinteger dimensions,
		...
	)
{
	va_list ap;
	fbinteger res;

	va_start( ap, dimensions );
	res = hRedim( array, element_len, TRUE, isvarlen, dimensions, ap );
	va_end( ap );

	return res;
}
