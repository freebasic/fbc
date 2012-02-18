/* fre() function */

#include "fb.h"

#if defined HOST_DOS
	#include <dpmi.h>
#elif defined HOST_FREEBSD
	#include <sys/sysctl.h>
	#include <sys/vmmeter.h>
	#include <vm/vm_param.h>
#elif defined HOST_LINUX
	#include <sys/sysinfo.h>
#elif defined HOST_WIN32
	#include <windows.h>
#endif

FBCALL unsigned int fb_GetMemAvail( int mode )
{
#if defined( HOST_DOS )
	__dpmi_free_mem_info info;
	(void)__dpmi_get_free_memory_information(&info);
	return info.total_number_of_free_pages * 4096;

#elif defined( HOST_FREEBSD )
	int mib[2] = { CTL_VM, VM_METER };
	struct vmtotal vmt;
	size_t size = sizeof(struct vmtotal);
	if( sysctl( mib, 2, &vmt, &size, NULL, 0 ) )
		return 0;
	return vmt.t_free * sysconf( _SC_PAGE_SIZE );

#elif defined( HOST_LINUX )
	return get_avphys_pages() * sysconf(_SC_PAGE_SIZE);

#elif defined( HOST_WIN32 )
	MEMORYSTATUS ms;
	ms.dwLength = sizeof( MEMORYSTATUS );
	GlobalMemoryStatus( &ms );
	return ms.dwAvailPhys;

#elif defined( HOST_XBOX )
	MM_STATISTICS ms;
	MmQueryStatistics(&ms);
	return ms.AvailablePages * 4096;

#else
	/* !!!WRITEME!!! */
	return 0;

#endif
}
