/* getxy entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL void fb_GetXY( int *col, int *row )
{
	FB_LOCK();

	if( __fb_ctx.hooks.getxyproc )
		__fb_ctx.hooks.getxyproc( col, row );
	else
		fb_ConsoleGetXY( col, row );

	FB_UNLOCK();
}

