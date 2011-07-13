/*
 * libfb_io_viewupdate.c -- view print update (console, no gfx) for Linux
 *
 * chng: jan/2005 written [DrV]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
void fb_ConsoleViewUpdate(void)
{
	if (!__fb_con.inited)
		return;
	
	fb_hTermOut(SEQ_SCROLL_REGION, fb_ConsoleGetBotRow(), fb_ConsoleGetTopRow());
}
