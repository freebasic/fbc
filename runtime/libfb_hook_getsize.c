/*
 * hook_getsize.c -- getsize entrypoint, default to console mode
 *
 * chng: dec/2004 written [v1ctor]
 *
 */

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

