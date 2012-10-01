/* timer() function */

#include "../fb.h"
#include <time.h>
#include <windows.h>

#define TIMER_NONE    0
#define TIMER_NORMAL  1
#define TIMER_HIGHRES 2
static int timer = TIMER_NONE;
static double frequency;

FBCALL double fb_Timer( void )
{
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
}
