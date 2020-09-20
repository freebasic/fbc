/* ERASE for arrays to free memory

   fb_ArrayErase() is called for dynamic arrays and static arrays

   if it is known at compile time that the array is static (fixed length)
   then:
      for plain arrays: fbc calls fb_ArrayClear()
      for object arrays: fbc calls fb_ArrayClearObj()
      for FBSTRING arrays: fbc calls fb_ArrayDestructStr()

   Otherwise if the array is dynamic or is unknown to be static at 
   compile-time, then:
      for plain arrays: fbc calls fb_ArrayErase()
      for object arrays: fbc calls fb_ArrayEraseObj()
      for FBSTRING arrays: fbc calls fb_ArrayStrErase()

   fb_ArrayErase() is also called indirectly from rtlib to free the
   memory associated with the array.
*/

#include "fb.h"

FBCALL int fb_ArrayErase( FBARRAY *array )
{
	/* ptr can be NULL, for global dynamic arrays that were never allocated,
	   but will still be destroyed on program exit */
	if( array->ptr ) {

		/* fixed length?  then it can't be resized.
		   just clear the elements and leave the descriptor as-is. */
		if( array->flags & FBARRAY_FLAGS_FIXED_LEN ) {
			fb_ArrayClear( array );

		/* otherwise it's dynamic: free memory */
		} else {
			free( array->ptr );
			fb_ArrayResetDesc( array );
		}
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
