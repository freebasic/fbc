/* condition variable functions */

#include "../fb.h"

FBCALL FBCOND *fb_CondCreate( void )
{
	return NULL;
}

FBCALL void fb_CondDestroy( FBCOND *cond )
{
}

FBCALL void fb_CondSignal( FBCOND *cond )
{
}

FBCALL void fb_CondBroadcast( FBCOND *cond )
{
}

FBCALL void fb_CondWait( FBCOND *cond, FBMUTEX *mutex )
{
}
