/* cls entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL void fb_Cls( int mode )
{

	fb_DevScrnInit_NoOpen( );

	FB_LOCK();

	if( __fb_ctx.hooks.clsproc )
		__fb_ctx.hooks.clsproc( mode );
	else
        fb_ConsoleClear( mode );

    FB_HANDLE_SCREEN->line_length = 0;

	FB_UNLOCK();

}
