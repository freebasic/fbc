/*
 * sys_fmem.c -- fre function for Windows
 *
 * chng: dec/2004 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL unsigned int fb_GetMemAvail ( int mode )
{

	MEMORYSTATUS ms;

	ms.dwLength = sizeof( MEMORYSTATUS );
	GlobalMemoryStatus( &ms );

	return ms.dwAvailPhys;

}

