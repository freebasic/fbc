/* libfb initialization for DOS */

#include "../fb.h"
#include "fb_private_console.h"
#include "../fb_private_thread.h"
#include <float.h>
#include <unistd.h>
#include <conio.h>

FB_CONSOLE_CTX __fb_con;
char *__fb_startup_cwd;

#ifdef ENABLE_MT
	extern int pthread_mutexattr_settype(pthread_mutexattr_t *attr, int kind);
	static pthread_mutex_t __fb_global_mutex;
	static pthread_mutex_t __fb_string_mutex;
	static pthread_mutex_t __fb_graphics_mutex;
	static pthread_mutex_t __fb_math_mutex;
	FBCALL void fb_Lock     ( void ) { pthread_mutex_lock  ( &__fb_global_mutex ); }
	FBCALL void fb_Unlock   ( void ) { pthread_mutex_unlock( &__fb_global_mutex ); }
	FBCALL void fb_StrLock  ( void ) { pthread_mutex_lock  ( &__fb_string_mutex ); }
	FBCALL void fb_StrUnlock( void ) { pthread_mutex_unlock( &__fb_string_mutex ); }
	FBCALL void fb_GraphicsLock  ( void ) { pthread_mutex_lock  ( &__fb_graphics_mutex ); }
	FBCALL void fb_GraphicsUnlock( void ) { pthread_mutex_unlock( &__fb_graphics_mutex ); }
	FBCALL void fb_MathLock  ( void ) { pthread_mutex_lock  ( &__fb_math_mutex ); }
	FBCALL void fb_MathUnlock( void ) { pthread_mutex_unlock( &__fb_math_mutex ); }
#endif

void fb_hInit( void )
{

	#ifdef ENABLE_MT
		pthread_mutexattr_t attr;
	#endif

	/* set FPU precision to 64-bit and round to nearest (as in QB) */
	_control87(PC_64|RC_NEAR, MCW_PC|MCW_RC);

	/* turn off blink */
	intensevideo();

	memset( &__fb_con, 0, sizeof( FB_CONSOLE_CTX ) );

	__fb_startup_cwd = getcwd(NULL, 1024);
	fb_hConvertPath( __fb_startup_cwd );

	#ifdef ENABLE_MT
		pthread_mutexattr_init(&attr);
		pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
		/* Init multithreading support */
		pthread_mutex_init(&__fb_global_mutex, &attr);
		pthread_mutex_init(&__fb_string_mutex, &attr);
		pthread_mutex_init(&__fb_graphics_mutex, &attr);
		pthread_mutex_init(&__fb_math_mutex, &attr);
	#endif

}

void fb_hEnd( int unused )
{

#ifdef ENABLE_MT
	/* Release multithreading support resources */
	pthread_mutex_destroy(&__fb_global_mutex);
	pthread_mutex_destroy(&__fb_string_mutex);
	pthread_mutex_destroy(&__fb_graphics_mutex);
	pthread_mutex_destroy(&__fb_math_mutex);
#endif

}
