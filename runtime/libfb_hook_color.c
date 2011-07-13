/*
 * hook_color.c -- color entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_Color( int fc, int bc, int flags )
{
	int cur;

	FB_LOCK();

	if( __fb_ctx.hooks.colorproc )
		cur = __fb_ctx.hooks.colorproc( fc, bc, flags );
	else
		cur = fb_ConsoleColor( fc, bc, flags );

	FB_UNLOCK();

	return cur;
}
