/* console CLS statement */

#include "../fb.h"
#include "fb_private_console.h"

void fb_ConsoleClear( int mode )
{
	EM_ASM({
        __fb_rtlib.console.clear();
    });
}
