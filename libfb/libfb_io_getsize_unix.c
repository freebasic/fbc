/*
 * io_getsize.c -- get size (console, no gfx) function for Linux
 *
 * chng: jan/2005 written [lillo]
 *       feb/2005 rewritten to remove ncurses dependency [lillo]
 *
 */

#include "fb.h"


/*:::::*/
FBCALL void fb_ConsoleGetSize( int *cols, int *rows )
{
	if (cols) {
		if (__fb_con.inited)
			*cols = __fb_con.w;
		else
			*cols = 80;
	}
	
    if (rows) {
		if (__fb_con.inited)
			*rows = __fb_con.h;
		else
			*rows = 24;
    }
}
