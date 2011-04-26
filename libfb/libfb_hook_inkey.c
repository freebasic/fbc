/*
 * hook_inkey.c -- inkey$ entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_Inkey( void )
{
	FBSTRING *res;
	
	FB_LOCK();
	
	if( __fb_ctx.hooks.inkeyproc )
		res = __fb_ctx.hooks.inkeyproc( );
	else
		res = fb_ConsoleInkey( );

	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_Getkey( void )
{
	int res;
	
	FB_LOCK();
	
	if( __fb_ctx.hooks.getkeyproc )
		res = __fb_ctx.hooks.getkeyproc( );
	else
		res = fb_ConsoleGetkey( );

	FB_UNLOCK();
	
	return res;
}

/*:::::*/
FBCALL int fb_KeyHit( void )
{
	int res;
	
	FB_LOCK();

	if( __fb_ctx.hooks.keyhitproc )
		res = __fb_ctx.hooks.keyhitproc( );
	else
		res = fb_ConsoleKeyHit( );
	
	FB_UNLOCK();
	
	return res;
}
