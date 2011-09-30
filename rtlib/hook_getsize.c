/* getsize entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL void fb_GetSize( int *cols, int *rows )
{
	FB_LOCK();

	if( __fb_ctx.hooks.getsizeproc )
		__fb_ctx.hooks.getsizeproc( cols, rows );
	else
		fb_ConsoleGetSize( cols, rows );

	FB_UNLOCK();
}

