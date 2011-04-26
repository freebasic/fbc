/*
 * time_settime.c -- set time function for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */


#include "fb.h"

#include <dos.h>

/*:::::*/
int fb_hSetTime( int h, int m, int s )
{
	struct time t;

	t.ti_hour = h;
	t.ti_min = m;
	t.ti_sec = s;
	t.ti_hund = 0;

	settime(&t);
	
	return 0;
}

