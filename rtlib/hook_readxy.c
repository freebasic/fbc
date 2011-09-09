/* reads color valoe or character from X/Y position */

#include "fb.h"

/*:::::*/
FBCALL unsigned int fb_ReadXY( int col, int row, int colorflag )
{
    unsigned int res;

    FB_LOCK();

    if( __fb_ctx.hooks.readxyproc ) {
        res = __fb_ctx.hooks.readxyproc( col, row, colorflag );
    } else {
        res = fb_ConsoleReadXY( col, row, colorflag );
    }

    FB_UNLOCK();

	return res;
}
