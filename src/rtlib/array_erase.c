/* erase function for dynamic arrays */

#include "fb.h"

/*:::::*/
FBCALL int fb_ArrayErase
	( 
		FBARRAY *array, 
		int isvarlen 
	)
{
    /* not an error, see fb_ArrayEraseObj() */
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OK );
    
    if( isvarlen != 0 )
    	fb_hArrayDtorStr( array, NULL, 0 );

    free( array->ptr );
    fb_ArrayResetDesc( array );

    return fb_ErrorSetNum( FB_RTERROR_OK );
}


