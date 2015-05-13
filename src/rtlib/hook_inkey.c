/* inkey$ entrypoint, default to console mode */

#include "fb.h"

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

FBCALL int fb_Getkey( void )
{
	FB_GETKEYPROC getkeyproc;

	/* getkey() is blocking, thus we shouldn't hold the FB_LOCK() for the
	   whole duration, but only when needed, as short as possible, to allow
	   other hooks to be called in the meantime. This of course requires
	   the fb_ConsoleGetkey/fb_GfxGetkey to take care of synchronization
	   themselves. */
	FB_LOCK();
	if( __fb_ctx.hooks.getkeyproc )
		getkeyproc = __fb_ctx.hooks.getkeyproc;
	else
		getkeyproc = fb_ConsoleGetkey;
	FB_UNLOCK();

	return getkeyproc( );
}

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
