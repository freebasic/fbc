/* beep function */

#include "../fb.h"
#include <windows.h>

FBCALL void fb_Beep( void )
{
	Beep( 1000, 250 );
}
