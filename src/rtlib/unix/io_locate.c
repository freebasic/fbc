/* console LOCATE statement */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleLocate( int row, int col, int cursor )
{
	int x, y;
	static int visible = 0x10000;

	if (!__fb_con.inited)
		return 0;

	if ((row <= 0) || (col <= 0))
		fb_ConsoleGetXY(&x, &y);

	BG_LOCK();

	if (col > 0)
		x = col;
	if (row > 0)
		y = row;

	fb_hRecheckConsoleSize( TRUE );

	if (x <= __fb_con.w)
		__fb_con.cur_x = x;
	else
		__fb_con.cur_x = __fb_con.w;
	if (y <= __fb_con.h)
		__fb_con.cur_y = y;
	else
		__fb_con.cur_y = __fb_con.h;
	fb_hTermOut(SEQ_LOCATE, x-1, y-1);
	if (cursor == 0) {
		fb_hTermOut(SEQ_HIDE_CURSOR, 0, 0);
		visible = 0;
	}
	else if (cursor == 1) {
		fb_hTermOut(SEQ_SHOW_CURSOR, 0, 0);
		visible = 0x10000;
	}

	BG_UNLOCK();

	return (x & 0xFF) | ((y & 0xFF) << 8) | visible;
}
