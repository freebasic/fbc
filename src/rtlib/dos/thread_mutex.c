/* mutex handling routines */

#include "../fb.h"
#include "../fb_private_thread.h"

FBCALL FBMUTEX *fb_MutexCreate( void )
{

#if defined ENABLE_MT
	FBMUTEX *mutex = (FBMUTEX *)malloc( sizeof( FBMUTEX ) );
	if( !mutex )
		return NULL;

	pthread_mutex_init( &mutex->id, NULL );

	return mutex;
#else
	return NULL;
#endif

}

FBCALL void fb_MutexDestroy( FBMUTEX *mutex )
{

#if defined ENABLE_MT
	if( mutex ) {
		pthread_mutex_destroy( &mutex->id );
		free( (void *)mutex );
	}
#endif

}

FBCALL void fb_MutexLock( FBMUTEX *mutex )
{

#if defined ENABLE_MT
	if( mutex ) {
		pthread_mutex_lock( &mutex->id );
	}
#endif

}

FBCALL void fb_MutexUnlock( FBMUTEX *mutex )
{

#if defined ENABLE_MT
	if( mutex ) {
		pthread_mutex_unlock( &mutex->id );
	}
#endif

}
