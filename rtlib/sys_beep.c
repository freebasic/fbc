/* beep function */

#include "fb.h"
#if defined HOST_UNIX
	#include "fb_private_console.h"
#elif defined HOST_WIN32
	#include <windows.h>
#endif

FBCALL void fb_Beep( void )
{
#if defined( HOST_WIN32 )
	Beep( 1000, 250 );
#elif defined( HOST_UNIX )
	fb_hTermOut(SEQ_BEEP, 0, 0);
#else
	putc('\a', stdout);
#endif
}
