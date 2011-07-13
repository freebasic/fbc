/*
 * time_tmr.c -- xbox timer function
 *
 * chng: jul/2005 written [DrV]
 *
 */

#include "../fb.h"
#include "fb_xbox.h"

/*:::::*/
FBCALL double fb_Timer ( void )
{
	LARGE_INTEGER t;
	
	KeQuerySystemTime(&t);
	
	return ((double)(t.QuadPart) * 100.0);
}
