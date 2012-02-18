/* recover stdio after redirection */

#include "fb.h"
#ifdef HOST_WIN32
	#include "fb_private_console.h"
#endif

FBCALL void fb_FileResetEx( int streamno )
{
	/*
		streamno
		0	Reset stdin
		1	Reset stdout
	*/

	if( streamno != 0 && streamno != 1 ) {
		return;
	}

	FB_LOCK();

#if defined( HOST_DOS )
	if( streamno == 0 ) {
		freopen( "CON", "r", stdin );
	} else {
		freopen( "CON", "w", stdout );
	}
#elif defined( HOST_WIN32 )
	/* in io_gethnd.c */
	fb_hConsoleResetHandles();

	if( streamno == 0 ) {
		freopen( "CONIN$", "r", stdin );
	} else {
		freopen( "CONOUT$", "w", stdout );
	}

	/* force handles to be reinitialized now */
	fb_hConsoleGetHandle( TRUE );
#else
	if( streamno == 0 ) {
		freopen( "/dev/tty", "r", stdin );
	} else {
		freopen( "/dev/tty", "w", stdout );
	}
#endif

	FB_UNLOCK();
}
