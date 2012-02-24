/* recover stdio after redirection */

#include "fb.h"
#ifdef HOST_WIN32
	#include "fb_private_console.h"
#endif

FBCALL void fb_FileResetEx( int streamno )
{
	FILE *result;

	/*
		streamno
		0	Reset stdin
		1	Reset stdout
	*/

	if( streamno != 0 && streamno != 1 ) {
		fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
		return;
	}

	FB_LOCK();

#if defined( HOST_DOS )
	if( streamno == 0 ) {
		result = freopen( "CON", "r", stdin );
	} else {
		result = freopen( "CON", "w", stdout );
	}
#elif defined( HOST_WIN32 )
	/* in io_gethnd.c */
	fb_hConsoleResetHandles();

	if( streamno == 0 ) {
		result = freopen( "CONIN$", "r", stdin );
	} else {
		result = freopen( "CONOUT$", "w", stdout );
	}

	/* force handles to be reinitialized now */
	fb_hConsoleGetHandle( TRUE );
#else
	if( streamno == 0 ) {
		result = freopen( "/dev/tty", "r", stdin );
	} else {
		result = freopen( "/dev/tty", "w", stdout );
	}
#endif

	FB_UNLOCK();

	fb_ErrorSetNum( result ? FB_RTERROR_OK : FB_RTERROR_FILEIO );
}
