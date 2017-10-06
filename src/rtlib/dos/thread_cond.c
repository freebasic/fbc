/* condition variable functions */

#include "../fb.h"
#include "../fb_private_thread.h"

#if defined ENABLE_MT
struct _FBCOND {
	pthread_cond_t id;
};
#endif

FBCALL FBCOND *fb_CondCreate( void )
{

#if defined ENABLE_MT
	FBCOND *cond;

	cond = (FBCOND *)malloc( sizeof( FBCOND ) );
	if( cond ) {
		pthread_cond_init( &cond->id, NULL );
	}

	return cond;
#else
	return NULL;
#endif
        
}

FBCALL void fb_CondDestroy( FBCOND *cond )
{

#if defined ENABLE_MT
	if( cond ) {
		pthread_cond_destroy( &cond->id );
		free( (void *)cond );
	}
#endif
        
}

FBCALL void fb_CondSignal( FBCOND *cond )
{

#if defined ENABLE_MT
	if( cond ) {
		pthread_cond_signal( &cond->id );
	}
#endif
        
}

FBCALL void fb_CondBroadcast( FBCOND *cond )
{

#if defined ENABLE_MT
	if( cond ) {
		pthread_cond_broadcast( &cond->id );
	}
#endif
        
}

FBCALL void fb_CondWait( FBCOND *cond, FBMUTEX *mutex )
{

#if defined ENABLE_MT
	if( cond && mutex ) {
		pthread_cond_wait( &cond->id, &mutex->id );
	}
#endif

}
