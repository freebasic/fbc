/*
 * thread_mutex.c -- DOS mutex handling routines (empty)
 *
 * chng: feb/2005 written [DrV]
 *
 */


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
