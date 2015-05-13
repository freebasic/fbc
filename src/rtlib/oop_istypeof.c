/* is operator */

#include "fb.h"

FBCALL int fb_IsTypeOf( FB_OBJECT *obj, FB_RTTI *typeRTTI )
{
	if( obj == NULL )
		return FB_FALSE;
	
	FB_RTTI *objRTTI = ((FB_BASEVT *)(((unsigned char *)obj->pVT) - sizeof( FB_BASEVT )))->pRTTI;
	while( objRTTI != NULL )
	{	
		/* note: can't compare just the address because object or type could be declared in a DLL */
		if( strcmp( objRTTI->id, typeRTTI->id ) == 0 ) 
			return FB_TRUE;
			
		objRTTI = objRTTI->pRTTIBase;
	}
	
	return FB_FALSE;
}
