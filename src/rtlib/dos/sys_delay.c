#include "../fb.h"
#if defined ENABLE_MT
	#include "../fb_private_thread.h"
#endif
#include <unistd.h>

FBCALL void fb_Delay( int msecs )
{
#if defined ENABLE_MT
        __pthread_usleep(msecs * 1000);
#else
        usleep(msecs * 1000);
#endif
}
