/* fre function for FreeBSD */

#include "fb.h"
#include <unistd.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/vmmeter.h>
#include <vm/vm_param.h>

/*:::::*/
FBCALL unsigned int fb_GetMemAvail ( int mode )
{
	int mib[2];
	struct vmtotal vmt;
	size_t size;
	
	mib[0] = CTL_VM;
	mib[1] = VM_METER;
	size = sizeof(struct vmtotal);
	
	if( sysctl( mib, 2, &vmt, &size, NULL, 0 ) )
	  return 0;

	return vmt.t_free * sysconf( _SC_PAGE_SIZE );
}
