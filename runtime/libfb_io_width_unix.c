/*
 * io_width.c -- width (console, no gfx) for Linux
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb.h"

/*:::::*/
int fb_ConsoleWidth( int cols, int rows )
{
	int cur = (__fb_con.inited ? (__fb_con.w | (__fb_con.h << 16)) : (80 | (25 << 16)));
	
	if ((cols > 0) || (rows > 0)) {
		
		BG_LOCK();
		
		if (cols <= 0)
			cols = __fb_con.w;
		if (rows <= 0)
			rows = __fb_con.h;
		fb_hTermOut(SEQ_WINDOW_SIZE, rows, cols);

		BG_UNLOCK();
		
		fb_ConsoleClear( 0 );
	}

	return cur;
}
