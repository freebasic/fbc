/* timer() function */

#include "fb.h"
#include <time.h>

#if defined HOST_UNIX
	#include <sys/time.h>
#elif defined HOST_WIN32
	#include <windows.h>
	#define TIMER_NONE    0
	#define TIMER_NORMAL  1
	#define TIMER_HIGHRES 2
	static int timer = TIMER_NONE;
	static double frequency;
#endif

FBCALL double fb_Timer( void )
{
#if defined( HOST_DOS ) || defined( HOST_UNIX )
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return (((double)tv.tv_sec * 1000000.0) + (double)tv.tv_usec) * 0.000001;

#elif defined( HOST_WIN32 )
	LARGE_INTEGER count;

	if( timer == TIMER_NONE ) {
		if( QueryPerformanceFrequency( &count ) ) {
			frequency = 1.0 / (double)count.QuadPart;
			timer = TIMER_HIGHRES;
		} else {
			timer = TIMER_NORMAL;
		}
	}

	if( timer == TIMER_NORMAL ) {
		return (double)GetTickCount( ) * 0.001;
	} else {
		QueryPerformanceCounter( &count );
		return (double)count.QuadPart * frequency;
	}

#elif defined( HOST_XBOX )
	LARGE_INTEGER t;
	KeQuerySystemTime(&t);
	return ((double)(t.QuadPart) * 100.0);

#else
#	error TODO
#endif
}
