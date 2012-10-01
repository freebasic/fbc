/* fb_CpuDetect() stub to be used when it's not implemented in asm */

#include "fb.h"

#if !defined HOST_X86

unsigned int fb_CpuDetect( void )
{
	return 0;
}

#endif
