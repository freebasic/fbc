/* end helper for Windows */

#include <stdlib.h>
#include "fb.h"


/*:::::*/
void fb_hEnd ( int unused )
{

#ifdef MULTITHREADED
	DeleteCriticalSection(&__fb_global_mutex);
	DeleteCriticalSection(&__fb_string_mutex);
#endif

}
