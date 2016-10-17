/* fre() function */

#include "../fb.h"
#include <unistd.h>

FBCALL size_t fb_GetMemAvail( int mode )
{
	return sysconf(_SC_AVPHYS_PAGES) * sysconf(_SC_PAGE_SIZE);
}
