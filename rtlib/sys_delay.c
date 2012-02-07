#include "fb.h"

FBCALL void fb_Delay( int msecs )
{
#if defined( HOST_DOS )
	usleep(msecs * 1000);

#elif defined( HOST_UNIX )
	struct timeval tv;
	tv.tv_sec = msecs / 1000;
	tv.tv_usec = (msecs % 1000) * 1000;
	select(0, NULL, NULL, NULL, &tv);

#elif defined( HOST_WIN32 )
	Sleep( msecs );

#elif defined( HOST_XBOX )
	XSleep( msecs );

#else
#	error TODO
#endif
}
