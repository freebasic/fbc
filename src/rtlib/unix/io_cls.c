/* console CLS statement */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleClear( int mode )
{
	int start, end, i;

	if (!__fb_con.inited || mode==1)
		return;

	BG_LOCK( );
	fb_hRecheckConsoleSize( TRUE );
	BG_UNLOCK( );

	fb_ConsoleGetView(&start, &end);
	if ((mode != 2) && (mode != (int)0xFFFF0000)) {
		start = 1;
		end = fb_ConsoleGetMaxRow();
	}
	if (start > __fb_con.h)
		start = __fb_con.h;
	if (end > __fb_con.h)
		end = __fb_con.h;
	for (i = start; i <= end; i++) {
		memset(__fb_con.char_buffer + ((i - 1) * __fb_con.w), ' ', __fb_con.w);
		memset(__fb_con.attr_buffer + ((i - 1) * __fb_con.w), __fb_con.fg_color | (__fb_con.bg_color << 4), __fb_con.w);
		fb_hTermOut(SEQ_LOCATE, 0, i-1);
		fb_hTermOut(SEQ_CLEOL, 0, 0);
	}
	fb_hTermOut(SEQ_LOCATE, 0, start-1);
	__fb_con.cur_y = start;
	__fb_con.cur_x = 1;
}
