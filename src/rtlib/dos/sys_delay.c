#include "../fb.h"
#if defined ENABLE_MT
	#include "../fb_private_thread.h"
#endif
#include <unistd.h>
#include <time.h>
#include <dpmi.h>

 
/* __fb_dos_no_dpmi_yield
 * - 0 (default), __dpmi_yield() is called in the busy loop for delays
 * - non-zero, do not call __dpmi_yield() which seems will prevent
 *   crashes under some dos extenders
 *
 * in fb:
 *   extern "c"
 *     extern as unsigned long __fb_dos_no_dpmi_yield
 *   end extern
 *   __fb_dos_no_dpmi_yield = 1
 */

extern unsigned int __fb_dos_no_dpmi_yield;
unsigned int __fb_dos_no_dpmi_yield = 0;

#if !defined(ENABLE_MT)

/* usleep() copied from djgpp libc implementation */
static unsigned int usleep_private(unsigned int _useconds)
{
	clock_t cl_time;
	clock_t start_time = clock();

	/* 977 * 1024 is about 1e6.  The funny logic keeps the math from
	   overflowing for large _useconds */
	_useconds >>= 10;
	cl_time = _useconds * CLOCKS_PER_SEC / 977;

	while (1)
	{
		clock_t elapsed = clock() - start_time;
		if (elapsed >= cl_time)
		{
			break;
		}
	}
	return 0;
}
#endif /* !defined(ENABLE_MT) */

FBCALL void fb_Delay( int msecs )
{
#if defined ENABLE_MT
	__pthread_usleep(msecs * 1000);
#else
	if( __fb_dos_no_dpmi_yield )
	{
		usleep_private(msecs * 1000);
	}
	else
	{
		usleep(msecs * 1000);
	}
#endif
}
