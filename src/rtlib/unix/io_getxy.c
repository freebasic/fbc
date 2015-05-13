#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
	int x = __fb_con.cur_x, y = __fb_con.cur_y;

	if (__fb_con.inited) {
		/* Note we read reply from stdin, NOT from __fb_con.f_in */
		BG_LOCK();

#ifdef HOST_LINUX
		if( fb_hTermQuery( SEQ_QUERY_CURSOR, &y, &x ) == FALSE )
#endif
		{
			x = __fb_con.cur_x;
			y = __fb_con.cur_y;
		}

		BG_UNLOCK();
	}
	if (col)
		*col = x;
	if (row)
		*row = y;
}
