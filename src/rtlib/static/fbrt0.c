/* FB runtime initialization and cleanup

   We use a global constructor and destructor for this. Where possible they
   should run first/last respectively, such that it's safe for FB programs to
   use the FB runtime from inside its own global ctors/dtors. */

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

/* This puts the init/exit global ctor/dtor for the rtlib in the sorted
   ctors/dtors section. A named section of .?tors.65435 = Priority(100).
   (65535 - 100 = 65435)

   This is what __attribute__((constructor(100))) would do; but that would also
   trigger a gcc warning, because priorities 0..100 are "reserved for the
   implementation", so we can't use that.

   Furthermore, __attribute__((constructor(priority))) isn't supported on
   Darwin/MacOSX.
   TODO: figure out whether __attribute__((section(...))) with .ctors.65435
   works (and results in that ctor being run first). Otherwise we could just
   use plain __attribute__((constructor)) for this target.

   GCC on GNU/Linux seems to use .init_array.<0-padded priority> to implement
    __attribute__((constructor(priority))) now (instead of
   .ctors.<65535 - priority>), but .ctors.* still works, so it's probably ok to
   keep using it. */

#ifdef HOST_DARWIN

static void * priorityhDoInit __attribute__((section(".ctors.65435,"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section(".dtors.65435,"), used)) = fb_hDoExit;

/* custom segment names? */
static void * priorityhDoInit __attribute__((section("__CTORS,.ctors.65435"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section("__DTORS,.dtors.65435"), used)) = fb_hDoExit;

/* put into __DATA segment? like other global vars? */
static void * priorityhDoInit __attribute__((section("__DATA,.ctors.65435"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section("__DATA,.dtors.65435"), used)) = fb_hDoExit;

/* unnamed segment? probably not allowed by clang? */
static void * priorityhDoInit __attribute__((section(",.ctors.65435"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section(",.dtors.65435"), used)) = fb_hDoExit;

#else

static void * priorityhDoInit __attribute__((section(".ctors.65435"), used)) = fb_hDoInit;
static void * priorityhDoExit __attribute__((section(".dtors.65435"), used)) = fb_hDoExit;

#endif
