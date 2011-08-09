/* fre function for Linux */

#include "fb.h"
#include <unistd.h>
#include <sys/sysinfo.h>

/*:::::*/
FBCALL unsigned int fb_GetMemAvail ( int mode )
{

    return get_avphys_pages() * sysconf(_SC_PAGE_SIZE);

}

