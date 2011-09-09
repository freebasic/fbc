/* gety entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL int fb_GetY( void )
{
	int res;

	FB_LOCK();

	if( __fb_ctx.hooks.getyproc )
		res = __fb_ctx.hooks.getyproc( );
	else
		res = fb_ConsoleGetY( );

	FB_UNLOCK();

	return res;
}
