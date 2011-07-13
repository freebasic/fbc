/*
 * sys_sleep.c -- sleep function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

#include <unistd.h>

/*:::::*/
FBCALL void fb_Delay ( int msecs )
{

	usleep(msecs * 1000);

}

