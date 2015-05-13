/* get max row (console, no gfx) */

#include "fb.h"
#if defined HOST_DOS
	#include <conio.h>
#else
	#include "fb_private_console.h"
#endif

int fb_ConsoleGetMaxRow( void )
{
#if defined( HOST_DOS )
	struct text_info ti;
	gettextinfo( &ti );
	return ti.screenheight;

#elif defined( HOST_WIN32 )
	COORD max = GetLargestConsoleWindowSize( __fb_out_handle );
	return (max.Y == 0) ? FB_SCRN_DEFAULT_HEIGHT : max.Y + 1;

#elif defined( HOST_UNIX )
	return __fb_con.inited ? __fb_con.h : 24;

#else
	return 0;

#endif
}
