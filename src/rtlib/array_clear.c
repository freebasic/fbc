/* ERASE for static arrays: clear the elements 

   fb_ArrayClear() is called directly if it is known at
   compile time that the array is static (fixed length)

   fb_ArrayClear() is called indirectly through fb_ArrayClearObj()
   after the array elements have been destructed

   fb_ArrayDestructStr() clears the array so there is
   no need to call fb_ArrayClear() also

   for plain arrays: fbc calls fb_ArrayClear()
   for object arrays: fbc calls fb_ArrayClearObj()
   for FBSTRING arrays: fbc calls fb_ArrayDestructStr()
*/

#include "fb.h"

FBCALL int fb_ArrayClear( FBARRAY *array )
{
	if( array->ptr )
		memset( array->ptr, 0, array->size );

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
