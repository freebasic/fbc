/* beep function */

#include "fb.h"
#include <stdlib.h>

/*:::::*/
FBCALL void fb_Beep( void )
{
#if defined(HOST_WIN32)
	Beep( 1000, 250 );
#elif defined(HOST_UNIX)
	fb_hTermOut(SEQ_BEEP, 0, 0);
#else
	putc('\a', stdout);
#endif
}
