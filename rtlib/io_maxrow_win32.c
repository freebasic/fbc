/* get max row (console, no gfx) for Windows */

#include "fb.h"

/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
    COORD max = GetLargestConsoleWindowSize( __fb_out_handle );
    if( max.Y==0 )
        return FB_SCRN_DEFAULT_HEIGHT;
	return max.Y + 1;
}
