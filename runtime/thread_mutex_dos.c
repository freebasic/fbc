/* DOS mutex handling routines (empty) */

#include "fb.h"

/*:::::*/
FBCALL struct _FBMUTEX *fb_MutexCreate( void )
{
	return NULL;
}

/*:::::*/
FBCALL void fb_MutexDestroy( struct _FBMUTEX *mutex )
{
	/* */
}

/*:::::*/
FBCALL void fb_MutexLock( struct _FBMUTEX *mutex )
{
	/* */
}

/*:::::*/
FBCALL void fb_MutexUnlock( struct _FBMUTEX *mutex )
{
	/* */
}
