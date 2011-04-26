/*
 * hook_gety.c -- gety entrypoint, default to console mode
 *
 * chng: dec/2004 written [v1ctor]
 *
 */

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
