/* libfb initialization for Windows */

#include "../fb.h"
#include "fb_private_console.h"
#include <float.h>

#ifdef ENABLE_MT
static CRITICAL_SECTION __fb_global_mutex;
static CRITICAL_SECTION __fb_string_mutex;
static CRITICAL_SECTION __fb_mtcore_mutex;
static CRITICAL_SECTION __fb_graphics_mutex;
static CRITICAL_SECTION __fb_math_mutex;
FBCALL void fb_Lock( void )      { EnterCriticalSection( &__fb_global_mutex ); }
FBCALL void fb_Unlock( void )    { LeaveCriticalSection( &__fb_global_mutex ); }
FBCALL void fb_StrLock( void )   { EnterCriticalSection( &__fb_string_mutex ); }
FBCALL void fb_StrUnlock( void ) { LeaveCriticalSection( &__fb_string_mutex ); }
FBCALL void fb_MtLock( void )    { EnterCriticalSection( &__fb_mtcore_mutex ); }
FBCALL void fb_MtUnlock( void )  { LeaveCriticalSection( &__fb_mtcore_mutex ); }
FBCALL void fb_GraphicsLock  ( void ) { EnterCriticalSection( &__fb_graphics_mutex ); }
FBCALL void fb_GraphicsUnlock( void ) { LeaveCriticalSection( &__fb_graphics_mutex ); }
FBCALL void fb_MathLock  ( void ) { EnterCriticalSection( &__fb_math_mutex ); }
FBCALL void fb_MathUnlock( void ) { LeaveCriticalSection( &__fb_math_mutex ); }
#endif

FB_CONSOLE_CTX __fb_con /* not initialized */;

void fb_hInit( void )
{
#ifdef HOST_MINGW
#ifndef _clear87
/* if __STRICT_ANSI__ is defined the _controlfp function is not defined in some versions of mingw-gcc */
#define	_PC_64		0x00000000
#define	_RC_NEAR	0x00000000
#define	_MCW_RC		0x00000300	/* Rounding */
#define	_MCW_PC		0x00030000	/* Precision */
_CRTIMP unsigned int __cdecl __MINGW_NOTHROW _controlfp (unsigned int unNew, unsigned int unMask);
#endif
    /* set FPU precision to 64-bit and round to nearest (as in QB) */
    _controlfp( _PC_64|_RC_NEAR, _MCW_PC|_MCW_RC );
#elif defined HOST_X86
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

#ifdef ENABLE_MT
	InitializeCriticalSection(&__fb_global_mutex);
	InitializeCriticalSection(&__fb_string_mutex);
	InitializeCriticalSection(&__fb_mtcore_mutex);
	InitializeCriticalSection(&__fb_graphics_mutex);
	InitializeCriticalSection(&__fb_math_mutex);
#endif

	memset( &__fb_con, 0, sizeof( FB_CONSOLE_CTX ) );
}

void fb_hEnd( int unused )
{
#ifdef ENABLE_MT
	DeleteCriticalSection(&__fb_global_mutex);
	DeleteCriticalSection(&__fb_string_mutex);
	DeleteCriticalSection(&__fb_mtcore_mutex);
	DeleteCriticalSection(&__fb_graphics_mutex);
	DeleteCriticalSection(&__fb_math_mutex);
#endif
}
