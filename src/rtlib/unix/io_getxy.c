#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_ConsoleGetXY( int *col, int *row )
{
	int x, y;

	if (__fb_con.inited) {
		BG_LOCK();

		/* We always want to requery the cursor position here, because
		   the cursor position could have been changed since the last
		   update (and there is no signal to tell us when the cursor
		   position changed except if we ourselves do it).
		   Thus, we're disabling fb_hRecheckConsoleSize()'s own cursor
		   position update (which it would only do in case a SIGWINCH
		   happened, but not always like we want to do here), to avoid
		   unnecessary duplicate updates. */
		fb_hRecheckConsoleSize( FALSE );
		fb_hRecheckCursorPos( );

		x = __fb_con.cur_x;
		y = __fb_con.cur_y;

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
