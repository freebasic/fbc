#include "../fb.h"
#include <unistd.h>

FBCALL void fb_Delay( int msecs )
{
	usleep(msecs * 1000);
}
