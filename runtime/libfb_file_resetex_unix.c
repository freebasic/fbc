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
		FB_LOCK();

		if( streamno == 0 )
			freopen( "/dev/tty", "r", stdin );

		if( streamno == 1 )
			freopen( "/dev/tty", "w", stdout );

		FB_UNLOCK();
	}
}
