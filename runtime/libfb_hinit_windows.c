/*
 * init.c -- libfb initialization for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include <float.h>
#include "fb.h"

/* globals */
#ifdef MULTITHREADED
CRITICAL_SECTION __fb_global_mutex;
CRITICAL_SECTION __fb_string_mutex;
CRITICAL_SECTION __fb_mtcore_mutex;
#endif

FB_CONSOLE_CTX __fb_con /* not initialized */;

/*:::::*/
void fb_hInit ( void )
{
#ifdef HOST_MINGW
    /* set FPU precision to 64-bit and round to nearest (as in QB) */
    _controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );
#elif defined(__GNUC__) && defined(__i386__)
    {
        unsigned int control_word;
        /* Get FPU control word */
        __asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
        /* Set 64-bit and round to nearest */
        control_word = (control_word & 0xF0FF) | 0x300;
        /* Write back FPU control word */
        __asm__ __volatile__( "fldcw %0" : : "m" (control_word) );
    }
#endif

#ifdef MULTITHREADED
	InitializeCriticalSection(&__fb_global_mutex);
	InitializeCriticalSection(&__fb_string_mutex);
	InitializeCriticalSection(&__fb_mtcore_mutex);
#endif

	memset( &__fb_con, 0, sizeof( FB_CONSOLE_CTX ) );
}

#ifdef HOST_MINGW
/* needed now by MinGW, see http://lists-archives.org/mingw-users/12883-linking-error-with-msvc-6-0.html */
int _get_output_format( void )
{
	return 0;
}
#endif

