/*
 * io_maxrow.c -- get max row (console, no gfx) for Windows
 *
 * chng: nov/2004 written [v1ctor]
 *       jul/2005 mod: return 25 when function fails [mjs]
 *
 */

#include "fb.h"

/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
    COORD max = GetLargestConsoleWindowSize( __fb_out_handle );
    if( max.Y==0 )
        return FB_SCRN_DEFAULT_HEIGHT;
	return max.Y + 1;
}
