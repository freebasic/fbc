/*
 * sys_fmem.c -- fre function for xbox
 *
 * chng: jul/2005 written [DrV]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL unsigned int fb_GetMemAvail ( int mode )
{
	MM_STATISTICS ms;
	
	MmQueryStatistics(&ms);
	
	return ms.AvailablePages * 4096;

}
