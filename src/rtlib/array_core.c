/* dynamic arrays core */

#include "fb.h"

/* calculate the number of array elements based on the passed
   in to fb_hArrayRealloc().  Note that this is a different
   format than the arrary->dimTB[] table
*/
size_t fb_hArrayCalcElements
	(
		size_t dimensions,
		const ssize_t *lboundTB,
		const ssize_t *uboundTB
	)
{
	size_t i, elements;

	elements = (uboundTB[0] - lboundTB[0]) + 1;
	for( i = 1; i < dimensions; i++ )
		elements *= (uboundTB[i] - lboundTB[i]) + 1;

	return elements;
}

ssize_t fb_hArrayCalcDiff
	(
		size_t dimensions,
		const ssize_t *lboundTB,
		const ssize_t *uboundTB
	)
{
	size_t i, elements;
	ssize_t diff = 0;

	if( dimensions <= 0 )
		return 0;

	for( i = 0; i < dimensions-1; i++ )
	{
		elements = (uboundTB[i+1] - lboundTB[i+1]) + 1;
		diff = (diff + lboundTB[i]) * elements;
	}

	diff += lboundTB[dimensions-1];

	return -diff;
}

FBCALL size_t fb_ArrayLen( FBARRAY *array )
{
	return (array && array->ptr)
		? array->size / array->element_len : 0;

/*

	Previously, the number of elements was computed from
	the array descriptor's dimensions table.

	{
		size_t i, elements;
		FBARRAYDIM *dim;

		dim = &array->dimTB[0];
		elements = dim->elements;
		++dim;

		for( i = 1; i < array->dimensions; i++, dim++ )
			elements *= dim->elements;

		return elements;
	}
*/
}

FBCALL size_t fb_ArraySize( FBARRAY *array )
{
	return (array && array->ptr)
		? array->size : 0;
}
