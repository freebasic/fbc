/* FB runtime initialization and cleanup */

#include "../fb.h"

/* note: they must be static, or shared libraries in Linux would reuse the 
		 same function */

/*:::::*/
static void fb_hDoInit( void ) /* __attribute__((constructor)) */;
static void fb_hDoInit( void )
{
	/* the last to be defined, the first that will be called */
	fb_hRtInit( );
}

/*:::::*/
static void fb_hDoExit( void ) /* __attribute__((destructor)) */;
static void fb_hDoExit( void )
{
	/* the last to be defined, the last that will be called */

	fb_hRtExit( );
}

/* This puts the init/exit global ctor/dtor for the rtlib in the sorted ctors/dtors
   section.  A named section of .?tors.65435 = Priority(100) */

#ifdef HOST_DARWIN

static void * priorityhDoInit __attribute__((section(".ctors.65435,"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section(".dtors.65435,"), used)) = fb_hDoExit;

#else

static void * priorityhDoInit __attribute__((section(".ctors.65435"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section(".dtors.65435"), used)) = fb_hDoExit;

#endif
