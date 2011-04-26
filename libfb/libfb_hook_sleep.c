/*
 * time_sleep.c -- sleep function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

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

