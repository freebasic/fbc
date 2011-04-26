/*
 * hook_getxy.c -- getxy entrypoint, default to console mode
 *
 * chng: dec/2004 written [v1ctor]
 *
 */

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

