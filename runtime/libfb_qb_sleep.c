/*
 * SleepQB - QB compatible SLEEP
 *
 * chng: oct/2007 written [jeffm]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_SleepQB( int secs )
{
	fb_Sleep( secs < 0 ? secs : secs * 1000 );
}
