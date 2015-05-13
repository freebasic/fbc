/* view print update (console, no gfx) */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleViewUpdate( void )
{
	if (!__fb_con.inited)
		return;
	__fb_con.scroll_region_changed = TRUE;
	fb_hTermOut(SEQ_SCROLL_REGION, fb_ConsoleGetBotRow(), fb_ConsoleGetTopRow());
}
