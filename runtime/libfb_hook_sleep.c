/* sleep function */

#include "fb.h"

/*:::::*/
FBCALL void fb_Sleep ( int msecs )
{
    FB_SLEEPPROC sleepproc;
    FB_LOCK();
    sleepproc = __fb_ctx.hooks.sleepproc;
    FB_UNLOCK();
    if( sleepproc ) {
        sleepproc( msecs );
    } else {
        fb_ConsoleSleep( msecs );
    }
}

