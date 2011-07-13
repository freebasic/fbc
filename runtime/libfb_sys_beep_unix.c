/*
 * sys_beep.c -- beep function for Linux
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "fb.h"


/*:::::*/
FBCALL void beep(void)
{
	fb_hTermOut(SEQ_BEEP);
}
