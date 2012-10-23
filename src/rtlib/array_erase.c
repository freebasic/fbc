/* ERASE for dynamic arrays: free the array */

#include "fb.h"

FBCALL void fb_ArrayErase( FBARRAY *array )
{
	/* ptr can be NULL, for global dynamic arrays that were never allocated,
	   but will still be destroyed on program exit */
	if( array->ptr ) {
		free( array->ptr );
		fb_ArrayResetDesc( array );
	}
}
