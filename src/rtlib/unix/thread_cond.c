/* condition variable functions */

#include "../fb.h"
#include "../fb_private_thread.h"

struct _FBCOND {
	pthread_cond_t id;
};

FBCALL FBCOND *fb_CondCreate( void )
{
	FBCOND *cond;

	cond = (FBCOND *)malloc( sizeof( FBCOND ) );
	if( cond ) {
		pthread_cond_init( &cond->id, NULL );
	}

	return cond;
}

FBCALL void fb_CondDestroy( FBCOND *cond )
{
	if( cond ) {
		pthread_cond_destroy( &cond->id );
		free( (void *)cond );
	}
}

FBCALL void fb_CondSignal( FBCOND *cond )
{
	if( cond ) {
		pthread_cond_signal( &cond->id );
	}
}

FBCALL void fb_CondBroadcast( FBCOND *cond )
{
	if( cond ) {
		pthread_cond_broadcast( &cond->id );
	}
}

FBCALL void fb_CondWait( FBCOND *cond, FBMUTEX *mutex )
{
	if( cond && mutex ) {
		pthread_cond_wait( &cond->id, &mutex->id );
	}
}
