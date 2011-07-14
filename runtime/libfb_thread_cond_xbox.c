/* xbox condition variables handling routines */

#include "fb.h"

typedef struct _FBCOND
{
} FBCOND;


/*:::::*/
FBCALL FBCOND *fb_CondCreate( void )
{
	return NULL;
}

/*:::::*/
FBCALL void fb_CondDestroy( FBCOND *cond )
{
}

/*:::::*/
FBCALL void fb_CondSignal( FBCOND *cond )
{
}

/*:::::*/
FBCALL void fb_CondBroadcast( FBCOND *cond )
{
}

/*:::::*/
FBCALL void fb_CondWait( FBCOND *cond )
{
}
