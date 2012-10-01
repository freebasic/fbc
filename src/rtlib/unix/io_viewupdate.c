/* view print update (console, no gfx) */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleViewUpdate( void )
{
	if (!__fb_con.inited)
		return;
	fb_hTermOut(SEQ_SCROLL_REGION, fb_ConsoleGetBotRow(), fb_ConsoleGetTopRow());
}
