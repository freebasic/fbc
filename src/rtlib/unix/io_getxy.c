#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
	int x, y;

	if (__fb_con.inited) {
		BG_LOCK();
		fb_hRecheckConsoleSize( );

#ifdef HOST_LINUX
		if( fb_hTermQuery( SEQ_QUERY_CURSOR, &y, &x ) == FALSE )
#endif
		{
			x = __fb_con.cur_x;
			y = __fb_con.cur_y;
		}

		BG_UNLOCK();
	} else {
		x = 1;
		y = 1;
	}

	if (col)
		*col = x;
	if (row)
		*row = y;
}
