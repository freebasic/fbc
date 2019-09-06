/* attach/reset array */

#include "fb.h"

FBCALL int fb_ArrayAttach( FBARRAY *array, array_dim_type *adt, int n, void *mp )
/***********************************************************************************************
 create array as memory overlay at mp, setup dimensions according to adt
***********************************************************************************************/
{
size_t     element_len = array->element_len;
size_t     dimensions = n;
size_t     i, elements, size;
ssize_t    diff;
ssize_t    lbTB[FB_MAXDIMENSIONS];
ssize_t    ubTB[FB_MAXDIMENSIONS];
ssize_t    *idx;
FBARRAYDIM *dim;

	/* For array attach only dynamic arrays are allowed. Dynamic arrays 
       get FB_MAXARRAYDIMS dimensions by default, so a change of dimension 
       count is possible. But as attaching is perfomed only if dimension 
       count is zero, array reset is necessary for an already attached array. */

	if ((array->flags & FBARRAY_FLAGS_FIXED_LEN) > 0)              
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if ((array->flags & FBARRAY_FLAGS_FIXED_DIM) > 0)              
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if (array->dimensions != 0)
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );


	idx = (ssize_t *) adt;

	/* load bounds */
	dim = &array->dimTB[0];
	for( i = 0; i < dimensions; i++ )
	{
		lbTB[i] = idx[i*2];                 
		ubTB[i] = idx[i*2 + 1];             

		if( lbTB[i] > ubTB[i] )
			return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

		dim->elements = (ubTB[i] - lbTB[i]) + 1;
		dim->lbound = lbTB[i];
		dim->ubound = ubTB[i];
		++dim;
	}

	/* add is_attached flag */
	array->flags = array->flags | FBARRAY_FLAGS_ATTACHED;


	/* calc size */
	elements = fb_hArrayCalcElements( dimensions, &lbTB[0], &ubTB[0] );
	diff = fb_hArrayCalcDiff( dimensions, &lbTB[0], &ubTB[0] ) * element_len;
	size = elements * element_len;

	array->ptr = mp;
	
	if( array->ptr == NULL )
		return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );


	array->data = ((unsigned char *)array->ptr) + diff;
	array->size = size;
	array->dimensions = dimensions;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}


FBCALL int fb_ArrayReset( FBARRAY *array )
/***********************************************************************************************
 reset (detach) attached array, don´t reset element_len (!)
***********************************************************************************************/
{
	if ((array->flags & FBARRAY_FLAGS_ATTACHED) == 0)              
	{
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}
	
	array->data = NULL;
	array->ptr = NULL;
	array->size = 0;
	array->dimensions = 0;
	memset( &array->dimTB[0], 0, FB_MAXDIMENSIONS * sizeof( FBARRAYDIM ) );
	array->flags = array->flags & ~FBARRAY_FLAGS_ATTACHED;

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

