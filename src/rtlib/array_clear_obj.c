/* ERASE function for static arrays of objects */

#include "fb.h"

/*:::::*/
FBCALL int fb_ArrayClearObj
	( 
		FBARRAY *array, 
		FB_DEFCTOR ctor, 
		FB_DEFCTOR dtor, 
		int dofill
	)
{
    /* not an error, see fb_ArrayEraseObj() */
    if( array->ptr == NULL )
    	return fb_ErrorSetNum( FB_RTERROR_OK );
    
    /* call dtors */
    if( dtor )
    	fb_hArrayDtorObj( array, dtor, 0 );
	
	if( dofill != FB_FALSE )
	{
		/* clear stills needed, the default dtor will just call other dtors
	   	   and free dynamic data, the non-dynamic fields would still the same */ 
		memset( array->ptr, 0, array->size );
		
		/* call ctors */
		if( ctor )
			fb_hArrayCtorObj( array, ctor, 0 );
			
	}

   	return fb_ErrorSetNum( FB_RTERROR_OK );
}
