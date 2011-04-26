/*
 * thread_core.c -- Linux (pthreads) thread creation and destruction
 *
 * chng: feb/2005 written [lillo]
 *
 */


#include <pthread.h>
#include "fb.h"


/* thread proxy to user's thread proc */
static void *threadproc( void *param )
{
	FBTHREAD *thread = param;

	/* call the user thread */
	thread->proc( thread->param );

	/* free mem */
	fb_TlsFreeCtxTb( );

	/* don't return NULL or exit() will be called */
	return (void *)1;
}

/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
{
	FBTHREAD *thread;
	pthread_attr_t tattr;

	thread = (FBTHREAD *)malloc( sizeof(FBTHREAD) );
	if( !thread )
		return NULL;

	thread->proc	= proc;
	thread->param 	= param;

	if( pthread_attr_init( &tattr ) ) {
		free( thread );
		return NULL;
	}

	/* Solaris pthread.h does not define PTHREAD_STACK_MIN */
#ifdef PTHREAD_STACK_MIN
	stack_size = stack_size >= PTHREAD_STACK_MIN ? stack_size : PTHREAD_STACK_MIN;
#endif
	
	pthread_attr_setstacksize( &tattr, stack_size );

	if( pthread_create( &thread->id, &tattr, threadproc, (void *)thread ) ) {
		free( (void *)thread );
		return NULL;
	}

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	pthread_join( thread->id, NULL );

	free( thread );
}
