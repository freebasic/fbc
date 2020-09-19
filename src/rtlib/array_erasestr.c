/* ERASE for dynamic arrays of var-len strings */

#include "fb.h"

FBCALL void fb_ArrayStrErase( FBARRAY *array )
{
	fb_ArrayDestructStr( array );

	/* only free the memory if it's not a fixed length array */
	if( array && !(array->flags & FBARRAY_FLAGS_FIXED_LEN) ) {
		fb_ArrayErase( array );
	}
}
