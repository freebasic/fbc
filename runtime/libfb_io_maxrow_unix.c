/*
 * io_maxrow.c -- get max row (console, no gfx) for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
int fb_ConsoleGetMaxRow( void )
{
	if (!__fb_con.inited)
		return 24;
	
	return __fb_con.h;
}
