/* timer() function */

#include "../fb.h"
#include <time.h>
#include <sys/time.h>

FBCALL double fb_Timer( void )
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (((double)tv.tv_sec * 1000000.0) + (double)tv.tv_usec) * 0.000001;
}
