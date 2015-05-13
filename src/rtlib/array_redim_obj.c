/* redim function */

#include "fb.h"

/*:::::*/
int fb_ArrayRedimObj
	( 
		FBARRAY *array, 
		int element_len, 
		FB_DEFCTOR ctor,
		FB_DEFCTOR dtor,
		int dimensions, 
		... 
	)
{
	va_list ap;
	int res;
	
    /* free old */
    if( array->ptr != NULL )
    {
    	if( dtor != NULL )
    		fb_ArrayEraseObj( array, dtor );
    	else
    		fb_ArrayErase( array, FALSE );
    }

	va_start( ap, dimensions );
	res = fb_hArrayAlloc( array, element_len, FB_FALSE, ctor, dimensions, ap );
    va_end( ap );
    
    return res;
}

