/* sleep function for xbox */

#include "../fb.h"
#include "fb_xbox.h"

/*:::::*/
FBCALL void fb_Delay ( int msecs )
{
	XSleep( msecs );
}

