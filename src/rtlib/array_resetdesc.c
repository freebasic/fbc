/*!!!REMOVEME!!!*/
/* descriptor reset, for dynamic local arrays */

#include "fb.h"

FBCALL void fb_ArrayResetDesc( FBARRAY *array )
{
	array->data = NULL;
	array->ptr = NULL;
	array->size = 0;
	memset( &array->dimTB[0], 0, array->dimensions * sizeof( FBARRAYDIM ) );
}
