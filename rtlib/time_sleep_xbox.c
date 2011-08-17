/* sleep function */

#include "fb.h"

/*:::::*/
void fb_ConsoleSleep ( int msecs )
{
    /* NOTE: No need to test for input keys because sleep will be hooked
     *       when the application is switched to graphics mode and the
     *       console implementations for keyboard handling are only dummy
     *       functions.
     */

    fb_Delay( msecs );
}

