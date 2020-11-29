/* thread creation and destruction functions */

#include "../fb.h"
#include "../fb_private_thread.h"

/* thread proxy to user's thread proc */
#if defined ENABLE_MT
static void *threadproc( void *param )
{
	FBTHREADINFO *info = param;
	FBTHREAD *thread = info->thread;

	FB_TLSGETCTX( FBTHREAD )->self = thread;

	/* call the user thread */
	info->proc( info->param );
	free( info );

	/* free mem */
	fb_TlsFreeCtxTb( );

	/* don't return NULL or exit() will be called */
	return (void *)1;
}
#endif

FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, ssize_t stack_size )
{

#if defined ENABLE_MT
	FBTHREAD *thread;
	FBTHREADINFO *info;
	pthread_attr_t tattr;

	thread = (FBTHREAD *)malloc( sizeof( FBTHREAD ) );
	if( thread == NULL ) {
		return NULL;
	}

	info = (FBTHREADINFO *)malloc( sizeof( FBTHREADINFO ) );
	if( info == NULL ) {
		free( thread );
		return NULL;
	}

	info->proc = proc;
	info->param = param;
	info->thread = thread;
	thread->flags = 0;

	if( pthread_attr_init( &tattr ) ) {
		free( thread );
		free( info );
		return NULL;
	}

	/* Solaris pthread.h does not define PTHREAD_STACK_MIN */
#ifdef PTHREAD_STACK_MIN
	stack_size = stack_size >= PTHREAD_STACK_MIN ? stack_size : PTHREAD_STACK_MIN;
#endif

	pthread_attr_setstacksize( &tattr, stack_size );

	if( pthread_create( &thread->id, &tattr, threadproc, info ) ) {
		free( thread );
		free( info );
		thread = NULL;
	}

	pthread_attr_destroy( &tattr );

	return thread;

#else
	return NULL;
#endif

}

FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
#if defined ENABLE_MT
	/* A wait for the main thread or ourselves will never end */
	if(
		( thread == NULL ) ||
		( ( thread->flags & FBTHREAD_MAIN ) != 0 ) ||
		( thread == FB_TLSGETCTX( FBTHREAD )->self )
	) {
		return;
	}

	pthread_join( thread->id, NULL );

	free( thread );
#endif
}
