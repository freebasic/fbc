/* ERASE for dynamic arrays of objects: destruct elements and free the array

   1) if known at compile time that array is dynamic, then
      destruct elements and free the array.

   2) if unknown at compile time if array is dynamic or fixed length, then
      destruct the elements only
*/

#include "fb.h"

FBCALL int fb_ArrayEraseObj( FBARRAY *array, FB_DEFCTOR dtor )
{
	fb_ArrayDestructObj( array, dtor );

	if( array->flags & FBARRAY_FLAGS_FIXED_LEN ) {
		/* !!! TODO !!! need to call fb_ArrayClearObj */
		fb_ArrayClear( array );
	} else {
		fb_ArrayErase( array );
	}
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
