/*
 * sys_beep.c -- beep function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#include <stdlib.h>

/*:::::*/
FBCALL void fb_Beep( void )
{

#if defined(HOST_WIN32)
	Beep( 1000, 250 );
#else
	putc('\a', stdout);
#endif
	
}
