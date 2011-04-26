/*
 * time_tmr.c -- DOS timer# function
 *
 * chng: feb/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include <time.h>

/*:::::*/
FBCALL double fb_Timer( void )
{
        struct timeval tv;
        
        gettimeofday(&tv, NULL);
        
        return ( ((double)tv.tv_sec * 1000000.0) + (double)tv.tv_usec) * 0.000001;
}
