/* beep function */

#include "../fb.h"

FBCALL void fb_Beep( void )
{
	putc('\a', stdout);
}
