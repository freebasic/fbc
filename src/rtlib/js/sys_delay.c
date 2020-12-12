#include "../fb.h"
#include <emscripten.h>

FBCALL void fb_Delay( int msecs )
{
	
	emscripten_sleep(msecs);
}
