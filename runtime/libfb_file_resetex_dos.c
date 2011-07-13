/*
 * file_resetex - recover stdio after redirection
 *
 * chng: oct/2007 written [jeffm]
 *
 */

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
			freopen( "CON", "r", stdin );

		if( streamno == 1 )
			freopen( "CON", "w", stdout );

		FB_UNLOCK();
	}
}
