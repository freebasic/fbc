/* 'screen , pg, pg' entrypoint, default to console mode */

#include "fb.h"

FBCALL int fb_PageSet( int active, int visible )
{
	fb_DevScrnInit_NoOpen( );

	FB_LOCK();

	int res;

	if( __fb_ctx.hooks.pagesetproc )
		res = __fb_ctx.hooks.pagesetproc( active, visible );
	else {
		if( (active >= FB_CONSOLE_MAXPAGES) || (visible >= FB_CONSOLE_MAXPAGES) ) {
			FB_UNLOCK();
			return -1;
		}
        res = fb_ConsolePageSet( active, visible );
	}

	FB_UNLOCK();

	return res;
}
