/* Linux (pthreads) mutex handling routines */

#include <pthread.h>
#include "fb.h"

/*:::::*/
FBCALL FBMUTEX *fb_MutexCreate( void )
{
	FBMUTEX *mutex;

	mutex = (FBMUTEX *)malloc( sizeof(FBMUTEX) );
	if( !mutex )
		return NULL;

	pthread_mutex_init( &mutex->id, NULL );

	return mutex;
}

/*:::::*/
FBCALL void fb_MutexDestroy( FBMUTEX *mutex )
{
	if( mutex == NULL )
		return;

	pthread_mutex_destroy( &mutex->id );
	free( (void *)mutex );
}

/*:::::*/
FBCALL void fb_MutexLock( FBMUTEX *mutex )
{
	if( mutex == NULL )
		return;

	pthread_mutex_lock( &mutex->id );
}

/*:::::*/
FBCALL void fb_MutexUnlock( FBMUTEX *mutex )
{
	if( mutex == NULL )
		return;

	pthread_mutex_unlock( &mutex->id );
}
