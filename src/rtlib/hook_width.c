/* width entrypoint, default to console mode */

#include "fb.h"

/*:::::*/
FBCALL int fb_Width( int cols, int rows )
{
	int cur;

	fb_DevScrnInit_NoOpen( );

	FB_LOCK();

	if( __fb_ctx.hooks.widthproc ) {
		cur = __fb_ctx.hooks.widthproc( cols, rows );
	} else {
		cur = fb_ConsoleWidth( cols, rows );
	}

	if( cols>0 ) {
		FB_HANDLE_SCREEN->width = cols;
	}

	/* Reset VIEW PRINT */
	if( (cols > 0) || (rows > 0) ) {
		fb_ConsoleView( 0, 0 );
	}

	FB_UNLOCK();

	return ((cols<1 && rows<1) ? cur : 0);
}
