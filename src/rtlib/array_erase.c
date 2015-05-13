/* ERASE for dynamic arrays: free the array */

#include "fb.h"

FBCALL int fb_ArrayErase( FBARRAY *array, int isvarlen /* legacy */ )
{
	/* ptr can be NULL, for global dynamic arrays that were never allocated,
	   but will still be destroyed on program exit */
	if( array->ptr ) {
		if( isvarlen )
			fb_ArrayDestructStr( array );
		free( array->ptr );
		fb_ArrayResetDesc( array );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
