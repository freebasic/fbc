/* view print update (console, no gfx) */

#include "fb.h"
#include "fb_private_console.h"

void fb_ConsoleViewUpdate( void )
{
#if defined( HOST_DOS )
	int top = fb_ConsoleGetTopRow( );
	if( top >= 0 )
		++top;
	else
		top = 1;
	fb_ConsoleLocate( top, 1, -1 );

#elif defined( HOST_UNIX )
	if (!__fb_con.inited)
		return;
	fb_hTermOut(SEQ_SCROLL_REGION, fb_ConsoleGetBotRow(), fb_ConsoleGetTopRow());

#elif defined( HOST_WIN32 )
	fb_hUpdateConsoleWindow( );

#endif
}
