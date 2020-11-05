/* libfb initialization for xbox */

#include "../fb.h"

#ifdef ENABLE_MT
static CRITICAL_SECTION __fb_global_mutex;
static CRITICAL_SECTION __fb_string_mutex;
static CRITICAL_SECTION __fb_graphics_mutex;
static CRITICAL_SECTION __fb_math_mutex;
FBCALL void fb_Lock( void )      { EnterCriticalSection( &__fb_global_mutex ); }
FBCALL void fb_Unlock( void )    { LeaveCriticalSection( &__fb_global_mutex ); }
FBCALL void fb_StrLock( void )   { EnterCriticalSection( &__fb_string_mutex ); }
FBCALL void fb_StrUnlock( void ) { LeaveCriticalSection( &__fb_string_mutex ); }
FBCALL void fb_GraphicsLock  ( void ) { EnterCriticalSection( &__fb_graphics_mutex ); }
FBCALL void fb_GraphicsUnlock( void ) { LeaveCriticalSection( &__fb_graphics_mutex ); }
FBCALL void fb_MathLock  ( void ) { EnterCriticalSection( &__fb_math_mutex ); }
FBCALL void fb_MathUnlock( void ) { LeaveCriticalSection( &__fb_math_mutex ); }
#endif

void fb_hInit( void )
{
	unsigned int control_word;

	/* Get FPU control word */
	__asm__ __volatile__( "fstcw %0" : "=m" (control_word) : );
	/* Set 64-bit and round to nearest */
	control_word = (control_word & 0xF0FF) | 0x300;
	/* Write back FPU control word */
	__asm__ __volatile__( "fldcw %0" : : "m" (control_word) );


#ifdef ENABLE_MT
	/* !!!FIXME!!! replace with xbox/openxdk equivalents */
	InitializeCriticalSection(&__fb_global_mutex);
	InitializeCriticalSection(&__fb_string_mutex);
	InitializeCriticalSection(&__fb_graphics_mutex);
	InitializeCriticalSection(&__fb_math_mutex);
#endif
}

void fb_hEnd( int unused )
{
#ifdef ENABLE_MT
	DeleteCriticalSection(&__fb_global_mutex);
	DeleteCriticalSection(&__fb_string_mutex);
	DeleteCriticalSection(&__fb_graphics_mutex);
	DeleteCriticalSection(&__fb_math_mutex);
#endif
}
