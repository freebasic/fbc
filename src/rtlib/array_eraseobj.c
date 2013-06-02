/* ERASE for dynamic arrays of objects: destruct elements and free the array */

#include "fb.h"

FBCALL int fb_ArrayEraseObj( FBARRAY *array, FB_DEFCTOR dtor )
{
	fb_ArrayDestructObj( array, dtor );
	fb_ArrayErase( array, 0 );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
