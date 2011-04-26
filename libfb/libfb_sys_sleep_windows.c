/*
 * sys_sleep.c -- sleep function for Windows
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL void fb_Delay ( int msecs )
{

	Sleep( msecs );
}

