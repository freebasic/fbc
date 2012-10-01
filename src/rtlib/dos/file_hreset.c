#include "../fb.h"

int fb_hFileResetEx( int streamno )
{
	FILE *f;

	if( streamno == 0 )
		f = freopen( "CON", "r", stdin );
	else 
		f = freopen( "CON", "w", stdout );

	return (f != NULL);
}
