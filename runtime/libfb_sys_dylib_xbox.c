/* Dynamic library loading and symbols retrieving (not available on xbox) */

#include "fb.h"


/*:::::*/
FBCALL void *fb_DylibLoad( FBSTRING *library )
{
	return NULL;
}

/*:::::*/
FBCALL void *fb_DylibSymbol( void *library, FBSTRING *symbol )
{
	return NULL;
}


/*:::::*/
FBCALL void fb_DylibFree( void *library )
{
	/* */
}
