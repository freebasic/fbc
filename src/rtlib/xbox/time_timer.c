/* timer() function */

#include "../fb.h"
#include <time.h>

FBCALL double fb_Timer( void )
{
	LARGE_INTEGER t;
	KeQuerySystemTime(&t);
	return ((double)(t.QuadPart) * 100.0);
}
