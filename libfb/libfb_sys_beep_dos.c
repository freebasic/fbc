/*
 * sys_beep.c -- beep function for DOS
 *
 * chng: mar/2005 written [DrV]
 *
 */

#include "fb.h"


/*:::::*/
FBCALL void beep(void)
{
	putchar('\a');
}
