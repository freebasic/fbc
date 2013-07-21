/* fre() function */

#include "../fb.h"
#include <sys/sysinfo.h>

FBCALL size_t fb_GetMemAvail( int mode )
{
	return get_avphys_pages() * sysconf(_SC_PAGE_SIZE);
}
