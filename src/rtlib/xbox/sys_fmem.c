/* fre() function */

#include "../fb.h"

FBCALL size_t fb_GetMemAvail( int mode )
{
	MM_STATISTICS ms;
	MmQueryStatistics(&ms);
	return ms.AvailablePages * 4096;
}
