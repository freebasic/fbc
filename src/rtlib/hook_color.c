/* color entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL unsigned int fb_Color( unsigned int fc, unsigned int bc, int flags )
{
	unsigned int cur;

	FB_LOCK();

	if( __fb_ctx.hooks.colorproc )
		cur = __fb_ctx.hooks.colorproc( fc, bc, flags );
	else
		cur = fb_ConsoleColor( fc, bc, flags );

	FB_UNLOCK();

	return cur;
}
