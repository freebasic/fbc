#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleGetMaxRow( void )
{
	COORD max = GetLargestConsoleWindowSize( __fb_out_handle );
	return (max.Y == 0) ? FB_SCRN_DEFAULT_HEIGHT : max.Y + 1;
}
