/* sleep function for Windows */

#include "fb.h"

/*:::::*/
FBCALL void fb_Delay ( int msecs )
{

	Sleep( msecs );
}

