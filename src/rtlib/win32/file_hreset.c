#include "../fb.h"
#include "fb_private_console.h"

int fb_hFileResetEx( int streamno )
{
	FILE *f;

	fb_hConsoleResetHandles();

	if( streamno == 0 )
		f = freopen( "CONIN$", "r", stdin );
	else 
		f = freopen( "CONOUT$", "w", stdout );

	/* force handles to be reinitialized now */
	fb_hConsoleGetHandle( TRUE );

	return (f != NULL);
}
