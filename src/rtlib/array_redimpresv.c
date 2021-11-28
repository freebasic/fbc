/* redim preserve function */

#include "fb.h"

int fb_hArrayRealloc
	(
		FBARRAY *array,
		size_t element_len,
		int doclear,
		FB_DEFCTOR ctor,
		FB_DTORMULT dtor_mult,
		FB_DEFCTOR dtor,
		size_t dimensions,
		va_list ap
	)
{
	size_t i, elements, size;
	ssize_t diff;
	FBARRAYDIM *dim;
	ssize_t lbTB[FB_MAXDIMENSIONS];
	ssize_t ubTB[FB_MAXDIMENSIONS];
	unsigned char *this_;
	void *reallocTemp;

	/* ditto, see fb_hArrayAlloc() */
	if( (dimensions != array->dimensions) && (array->dimensions != 0) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* fixed length? */
	if( array->flags & FBARRAY_FLAGS_FIXED_LEN )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* load bounds */
	for( i = 0; i < dimensions; i++ )
	{
		lbTB[i] = va_arg( ap, ssize_t );
		ubTB[i] = va_arg( ap, ssize_t );

		if( lbTB[i] > ubTB[i] )
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* calc size */
	elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
	diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
	size = elements * element_len;

	/* shrinking the array? free unused elements */
	if( dtor_mult != NULL )
	{
		if( elements < fb_ArrayLen( array ) )
		{
			/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
			dtor_mult( array, dtor, elements );
		}
	}

	/* realloc */
	reallocTemp = realloc( array->ptr, size );
	if( reallocTemp == NULL )
		return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );

	array->ptr = reallocTemp;
	/* Have remainder? */
	if( size > array->size ) {
		/* Construct or clear new array elements: */
		/* Clearing is not needed if not requested, or if ctors will be called
		   (ctors take care of clearing themselves) */
		this_ = ((unsigned char *)array->ptr) + array->size;
		if( ctor ) {
			size_t objects = (size - array->size) / element_len;
			while( objects > 0 ) {
				/* !!!FIXME!!! check exceptions (only if rewritten in C++) */
				ctor( this_ );

				this_ += element_len;
				--objects;
			}
		} else if( doclear ) {
			memset( (void *)this_, 0, size - array->size );
		}
	}

	DBG_ASSERT( array->element_len == element_len || array->element_len == 0 );
	DBG_ASSERT( array->dimensions == dimensions || array->dimensions == 0 );

	array->data = ((unsigned char *)array->ptr) + diff;
	array->size = size;
	array->element_len = element_len;
	array->dimensions = dimensions;
	dim = &array->dimTB[0];
	for( i = 0; i < dimensions; i++, dim++ )
	{
		dim->elements = (ubTB[i] - lbTB[i]) + 1;
		dim->lbound = lbTB[i];
		dim->ubound = ubTB[i];
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

int fb_ArrayRedimPresvEx
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
