/* redim function */

#include "fb.h"

int fb_hArrayAlloc
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		FB_DEFCTOR ctor,
		size_t dimensions,
		va_list ap
	)
{
	size_t i, elements, size;
	ssize_t diff;
    FBARRAYDIM *dim;
	ssize_t lbTB[FB_MAXDIMENSIONS];
	ssize_t ubTB[FB_MAXDIMENSIONS];

    /* load bounds */
    dim = &array->dimTB[0];
    for( i = 0; i < dimensions; i++ )
    {
		lbTB[i] = va_arg( ap, ssize_t );
		ubTB[i] = va_arg( ap, ssize_t );

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

	/* Allocte new buffer */
	/* Clearing is not needed if not requested, or if ctors will be called
	   (ctors take care of clearing themselves) */
	if( doclear && (ctor == NULL) )
		array->ptr = calloc( size, 1 );
	else
		array->ptr = malloc( size );
    
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

    /* set descriptor */
    FB_ARRAY_SETDESC( array, element_len, dimensions, size, diff );

	/* call ctor for each element */
	if( ctor ) {
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

static int hRedim
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		int isvarlen,
		size_t dimensions,
		va_list ap
	)
{

	/* free old */
	fb_ArrayErase( array, isvarlen );

    return fb_hArrayAlloc( array, element_len, doclear, NULL, dimensions, ap );
}

int fb_ArrayRedimEx
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		int isvarlen,
		size_t dimensions,
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

/* legacy */
int fb_ArrayRedim
	(
		FBARRAY *array,
		size_t element_len,
		int isvarlen,
		size_t dimensions,
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
