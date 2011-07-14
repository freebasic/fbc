/* beep function for DOS */

#include "fb.h"

/*:::::*/
FBCALL void beep(void)
{
	putchar('\a');
}
