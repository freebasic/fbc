#include "../fb.h"
#include <sys/select.h>

FBCALL void fb_Delay( int msecs )
{
	struct timeval tv;
	tv.tv_sec = msecs / 1000;
	tv.tv_usec = (msecs % 1000) * 1000;
	select(0, NULL, NULL, NULL, &tv);
}
