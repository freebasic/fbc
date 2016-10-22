/* fre() function */

#include "../fb.h"
#include <mach/host_info.h>
#include <mach/mach_host.h>
#include <unistd.h>

FBCALL size_t fb_GetMemAvail( int mode )
{
	vm_statistics_data_t vmstat;
	mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
	if( host_statistics( mach_host_self(), HOST_VM_INFO, (host_info_t) &vmstat, &count) != KERN_SUCCESS )
	    return 0;
	return vmstat.free_count * getpagesize();
}
