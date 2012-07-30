/* fre() function */

#include "../fb.h"

FBCALL unsigned int fb_GetMemAvail( int mode )
{
	MM_STATISTICS ms;
	MmQueryStatistics(&ms);
	return ms.AvailablePages * 4096;
}
