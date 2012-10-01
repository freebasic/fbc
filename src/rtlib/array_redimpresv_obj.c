/* redim preserve function */

#include "fb.h"

/*:::::*/
int fb_ArrayRedimPresvObj
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
	
	va_start( ap, dimensions );

    /* new? */
    if( array->ptr == NULL )
    {
    	res = fb_hArrayAlloc( array, element_len, FB_FALSE, ctor, dimensions, ap );
    }	
    /* realloc.. */
    else
	{	
		FB_DTORMULT dtor_mult = (dtor != NULL? &fb_hArrayDtorObj : NULL );
		
		res = fb_hArrayRealloc( array, element_len, FB_FALSE, ctor, dtor_mult, dtor, dimensions, ap );
	}

    va_end( ap );
    
    return res;
}
