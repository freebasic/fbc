/*
 * sys_fmem.c -- fre function for Linux
 *
 * chng: dec/2004 written [lillo]
 *
 */

#include "fb.h"
#include <unistd.h>
#include <sys/sysinfo.h>

/*:::::*/
FBCALL unsigned int fb_GetMemAvail ( int mode )
{

    return get_avphys_pages() * sysconf(_SC_PAGE_SIZE);

}

