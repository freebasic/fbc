/*
 * exit.c -- end helper for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdlib.h>
#include "fb.h"


/*:::::*/
void fb_hEnd ( int unused )
{

#ifdef MULTITHREADED
	DeleteCriticalSection(&__fb_global_mutex);
	DeleteCriticalSection(&__fb_string_mutex);
	DeleteCriticalSection(&__fb_mtcore_mutex);
#endif

}
