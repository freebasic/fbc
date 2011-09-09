/* multikey entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL int fb_Multikey( int scancode )
{
	int res;
	
	FB_LOCK();
	
	if( __fb_ctx.hooks.multikeyproc )
		res = __fb_ctx.hooks.multikeyproc( scancode );
	else
		res = fb_ConsoleMultikey( scancode );

	FB_UNLOCK();
	
	return res;
}
