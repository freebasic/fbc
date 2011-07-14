/* libfb initialization for xbox */

#include <stdlib.h>
#include "fb.h"

#ifdef MULTITHREADED
CRITICAL_SECTION __fb_global_mutex;
CRITICAL_SECTION __fb_string_mutex;
#endif

/*:::::*/
void fb_hInit ( void )
{
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );


#ifdef MULTITHREADED

	/* !!!FIXME!!! replace with xbox/openxdk equivalents */

	InitializeCriticalSection(&__fb_global_mutex);
	InitializeCriticalSection(&__fb_string_mutex);

#endif

}
