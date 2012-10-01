/* QB compatible SLEEP */

#include "fb.h"

/*:::::*/
FBCALL void fb_SleepQB( int secs )
{
	fb_Sleep( secs < 0 ? secs : secs * 1000 );
}
