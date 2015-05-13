/* mutex handling routines */

#include "../fb.h"
#include "../fb_private_thread.h"

FBCALL FBMUTEX *fb_MutexCreate( void )
{
	FBMUTEX *mutex = (FBMUTEX *)malloc( sizeof( FBMUTEX ) );
	if( !mutex )
		return NULL;

	mutex->id = CreateSemaphore( NULL, 1, 1, NULL );

	return mutex;
}

FBCALL void fb_MutexDestroy( FBMUTEX *mutex )
{
	if( mutex ) {
		CloseHandle( mutex->id );
		free( (void *)mutex );
	}
}

FBCALL void fb_MutexLock( FBMUTEX *mutex )
{
	if( mutex ) {
		WaitForSingleObject( mutex->id, INFINITE );
	}
}

FBCALL void fb_MutexUnlock( FBMUTEX *mutex )
{
	if( mutex ) {
		ReleaseSemaphore( mutex->id, 1, NULL );
	}
}
