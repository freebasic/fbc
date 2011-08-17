/* DOS condition variables handling routines (empty) */

#include "fb.h"

/*:::::*/
FBCALL struct _FBCOND *fb_CondCreate( void )
{
	return NULL;
}

/*:::::*/
FBCALL void fb_CondDestroy( struct _FBCOND *cond )
{
	/* */
}

/*:::::*/
FBCALL void fb_CondSignal( struct _FBCOND *cond )
{
	/* */
}

/*:::::*/
FBCALL void fb_CondBroadcast( struct _FBCOND *cond )
{
	/* */
}

/*:::::*/
FBCALL void fb_CondWait( struct _FBCOND *cond, struct _FBMUTEX *mutex )
{
	/* */
}
