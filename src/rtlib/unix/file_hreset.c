#include "../fb.h"

int fb_hFileResetEx( int streamno )
{
	FILE *f;

	if( streamno == 0 )
		f = freopen( "/dev/tty", "r", stdin );
	else 
		f = freopen( "/dev/tty", "w", stdout );

	return (f != NULL);
}
