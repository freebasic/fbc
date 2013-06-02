/* ERASE for static arrays: clear the elements */
/* (for FBSTRING arrays, fb_ArrayStrErase() should be used instead */

#include "fb.h"

FBCALL int fb_ArrayClear( FBARRAY *array, int isvarlen /* legacy */ )
{
	if( array->ptr ) {
		if( isvarlen )
			fb_ArrayDestructStr( array );
		else
			memset( array->ptr, 0, array->size );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
