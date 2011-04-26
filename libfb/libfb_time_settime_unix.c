/*
 * time_htimeset.c -- set time function for Linux
 *
 * chng: jan/2005 written [nobody]
 *
 */


#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/time.h>
#include "fb.h"

/*:::::*/
int fb_hSetTime( int h, int m, int s )
{
	struct timeval tv;
	
	gettimeofday( &tv, NULL );
	tv.tv_sec -= (tv.tv_sec % 86400);
	tv.tv_sec += (h * 3600) + (m * 60) + s;
	if( settimeofday( &tv, NULL ) )
		return -1;
	
	return 0;
}

