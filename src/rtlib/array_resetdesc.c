/* descriptor reset, for dynamic local arrays */

#include "fb.h"

FBCALL void fb_ArrayResetDesc( FBARRAY *array )
{
	array->data = NULL;
	array->ptr = NULL;
	array->size = 0;
	/* array->element_len = 0; */
	/* array->dimensions = 0; */

	/* only keep flags we make decisions on.  These will
	   will have been set when the array descriptor was
	   first allocated and must be kept.
	*/
	array->flags &= FBARRAY_FLAGS_DIMENSIONS 
	                | FBARRAY_FLAGS_FIXED_DIM
	                | FBARRAY_FLAGS_FIXED_LEN;
	memset( &array->dimTB[0], 0, array->dimensions * sizeof( FBARRAYDIM ) );
}
