/* beep function */

#include "../fb.h"
#include "fb_private_console.h"

FBCALL void fb_Beep( void )
{
	fb_hTermOut(SEQ_BEEP, 0, 0);
}
