/* ERASE for static arrays: clear the elements */
/* (for FBSTRING arrays, fb_ArrayEraseStr() should be used instead */

#include "fb.h"

FBCALL void fb_ArrayClear( FBARRAY *array )
{
	if( array->ptr )
		memset( array->ptr, 0, array->size );
}
