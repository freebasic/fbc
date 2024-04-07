/* print string entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintBufferEx( const void *buffer, size_t len, int mask )
{
	FB_LOCK();

	if( __fb_ctx.hooks.printbuffproc ) {
		__fb_ctx.hooks.printbuffproc( buffer, len, mask );
	} else {
		fb_ConsolePrintBufferEx( buffer, len, mask );
	}

	FB_UNLOCK();

}

/*:::::*/
FBCALL void fb_PrintBuffer( const char *buffer, int mask )
{
	return fb_PrintBufferEx( buffer, strlen( buffer ), mask );
}
