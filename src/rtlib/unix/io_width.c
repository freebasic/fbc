/* console width() function */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleWidth( int cols, int rows )
{
	if( !__fb_con.inited )
		return (80 | (25 << 16));

	BG_LOCK( );
	fb_hRecheckConsoleSize( TRUE );
	BG_UNLOCK( );

	int cur = __fb_con.w | (__fb_con.h << 16);

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
