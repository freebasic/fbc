/* FB runtime initialization and cleanup

   We use a global constructor and destructor for this. Where possible they
   should run first/last respectively, such that it's safe for FB programs to
   use the FB runtime from inside its own global ctors/dtors. */

#include "../fb.h"

/* note: they must be static, or shared libraries in Linux would reuse the 
		 same function */

#ifdef HOST_DARWIN
	/* It seems like __attribute__((constructor(priority))) (or in general, ordering
	   ctors/dtors across modules) isn't supported on Darwin/MacOSX, so we just use
	   plain __attribute__((constructor)). */
	__attribute__((constructor)) static void fb_hDoInit( void )
	{
		fb_hRtInit( );
	}

	__attribute__((destructor)) static void fb_hDoExit( void )
	{
		fb_hRtExit( );
	}
#else
	static void fb_hDoInit( void )
	{
		fb_hRtInit( );
	}

	static void fb_hDoExit( void )
	{
		fb_hRtExit( );
	}

	/* This puts the init/exit global ctor/dtor for the rtlib in the sorted
	   ctors/dtors section. A named section of .?tors.65435 = Priority(100).
	   (65535 - 100 = 65435)

	   This is what __attribute__((constructor(100))) would do; but that would also
	   trigger a gcc warning, because priorities 0..100 are "reserved for the
	   implementation", so we can't use that.

	   GCC on GNU/Linux seems to use .init_array.<0-padded priority> to implement
	    __attribute__((constructor(priority))) now (instead of
	   .ctors.<65535 - priority>), but .ctors.* still works, so it's probably ok to
	   keep using it. */
	static void * priorityhDoInit __attribute__((section(".ctors.65435"), used)) = fb_hDoInit;
	static void * priorityhDoExit __attribute__((section(".dtors.65435"), used)) = fb_hDoExit;
#endif
