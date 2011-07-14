/* xbox mutex handling routines */

#include "fb.h"

typedef struct _FBMUTEX
{
} FBMUTEX;

/*:::::*/
FBCALL FBMUTEX *fb_MutexCreate( void )
{
	return NULL;
}

/*:::::*/
FBCALL void fb_MutexDestroy( FBMUTEX *mutex )
{
}

/*:::::*/
FBCALL void fb_MutexLock( FBMUTEX *mutex )
{
}

/*:::::*/
FBCALL void fb_MutexUnlock( FBMUTEX *mutex )
{
}
