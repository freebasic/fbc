/* ERASE for dynamic arrays of objects: destruct elements and free the array */

#include "fb.h"

FBCALL void fb_ArrayEraseObj( FBARRAY *array, FB_DEFCTOR dtor )
{
	fb_ArrayDestructObj( array, dtor );
	fb_ArrayErase( array );
}
