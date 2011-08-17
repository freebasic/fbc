/* view print update (console, no gfx) for Linux */

#include "fb.h"

/*:::::*/
void fb_ConsoleViewUpdate(void)
{
	if (!__fb_con.inited)
		return;
	
	fb_hTermOut(SEQ_SCROLL_REGION, fb_ConsoleGetBotRow(), fb_ConsoleGetTopRow());
}
