/* recover stdio after redirection */

#include "fb.h"

/*:::::*/
FBCALL void fb_FileResetEx ( int streamno )
{
	/*
		streamno
		0	Reset stdin
		1	Reset stdout
	*/

	if( streamno >= 0 && streamno <= 1 )
	{
		HANDLE h;

		FB_LOCK();

		/* in libfb_io_gethnd.c */
		fb_hConsoleResetHandles();

		if( streamno == 0 )
			freopen( "CONIN$", "r", stdin );

		if( streamno == 1 )
			freopen( "CONOUT$", "w", stdout );

		/* force handles to be reinitialized now */
		h = fb_hConsoleGetHandle( TRUE );

		FB_UNLOCK();
	}
}
