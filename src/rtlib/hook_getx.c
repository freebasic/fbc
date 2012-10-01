/* getx entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL int fb_GetX( void )
{
	int res;

	FB_LOCK();

	if( __fb_ctx.hooks.getxproc )
		res = __fb_ctx.hooks.getxproc( );
	else
		res = fb_ConsoleGetX( );

	FB_UNLOCK();

	return res;
}

