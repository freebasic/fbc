/*
 * sys_sleep.c -- sleep function for xbox
 *
 * chng: jul/2005 written [DrV]
 *
 */

#include "../fb.h"
#include "fb_xbox.h"

/*:::::*/
FBCALL void fb_Delay ( int msecs )
{
	XSleep( msecs );
}

