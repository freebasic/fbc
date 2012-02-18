/* mutex handling routines */

#include "fb.h"
#include "fb_private_thread.h"

FBCALL FBMUTEX *fb_MutexCreate( void )
{
#if defined( HOST_UNIX ) || defined( HOST_WIN32 )
	FBMUTEX *mutex = (FBMUTEX *)malloc( sizeof(FBMUTEX) );
	if( !mutex )
		return NULL;

#	if defined( HOST_UNIX )
		pthread_mutex_init( &mutex->id, NULL );
#	else
		mutex->id = CreateSemaphore(NULL, 1, 1, NULL);
#	endif

	return mutex;

#else
	return NULL;
#endif
}

FBCALL void fb_MutexDestroy( FBMUTEX *mutex )
{
#if defined( HOST_UNIX ) || defined( HOST_WIN32 )
	if( mutex ) {
#	if defined( HOST_UNIX )
		pthread_mutex_destroy( &mutex->id );
#	else
		CloseHandle( mutex->id );
#	endif
		free( (void *)mutex );
	}
#endif
}

FBCALL void fb_MutexLock( FBMUTEX *mutex )
{
#if defined( HOST_UNIX ) || defined( HOST_WIN32 )
	if( mutex ) {
#	if defined( HOST_UNIX )
		pthread_mutex_lock( &mutex->id );
#	else
		WaitForSingleObject( mutex->id, INFINITE );
#	endif
	}
#endif
}

FBCALL void fb_MutexUnlock( FBMUTEX *mutex )
{
#if defined( HOST_UNIX ) || defined( HOST_WIN32 )
	if( mutex ) {
#	if defined( HOST_UNIX )
		pthread_mutex_unlock( &mutex->id );
#	else
		ReleaseSemaphore( mutex->id, 1, NULL );
#	endif
	}
#endif
}
