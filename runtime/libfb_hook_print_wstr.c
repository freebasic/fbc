/*
 * hook_print_wstr.c -- print wstring entrypoint, default to console mode
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintBufferWstrEx( const FB_WCHAR *buffer, size_t len, int mask )
{
	FB_LOCK();

    if( __fb_ctx.hooks.printbuffwproc )
        __fb_ctx.hooks.printbuffwproc( buffer, len, mask );
    else
        fb_ConsolePrintBufferWstrEx( buffer, len, mask );

	FB_UNLOCK();

}

/*:::::*/
FBCALL void fb_PrintBufferWstr( const FB_WCHAR *buffer, int mask )
{

    return fb_PrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );

}
