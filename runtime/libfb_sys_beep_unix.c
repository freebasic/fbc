/* beep function for Linux */

#include "fb.h"

/*:::::*/
FBCALL void beep(void)
{
	fb_hTermOut(SEQ_BEEP);
}
