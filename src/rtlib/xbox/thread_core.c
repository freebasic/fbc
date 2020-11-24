/* thread creation and destruction functions */

#include "../fb.h"
#include "../fb_private_thread.h"
#include <xboxkrnl/xboxkrnl.h>

static void NTAPI threadproc(void *param1, void *param2)
{
	FBTHREADINFO *info = param1;
	FBTHREAD *thread = info->thread;
	FBTHREADFLAGS flags;

	FB_TLSGETCTX( FBTHREAD )->self = thread;

	/* call the user thread procedure */
	info->proc( info->param );
	free( info );

	/* free mem */
	fb_TlsFreeCtxTb( );

	flags = fb_AtomicSetThreadFlags( &thread->flags, FBTHREAD_EXITED );

	/* This thread has been detached, we can free the thread structure */
	if( flags & FBTHREAD_DETACHED ) {
		free( thread );
	}
}

FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, ssize_t stack_size )
{
	NTSTATUS status;
	FBTHREAD *thread;
	FBTHREADINFO *info;

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

	status = PsCreateSystemThreadEx( &thread->id, /* ThreadHandle */
	                                 0,           /* ThreadExtraSize */
	                                 /* stack_size??? */ 65536,       /* KernelStackSize */
	                                 0,           /* TlsDataSize */
	                                 NULL,        /* ThreadId */
	                                 info,        /* StartContext1 */
	                                 NULL,        /* StartContext2 */
	                                 FALSE,       /* CreateSuspended */
	                                 FALSE,       /* DebugStack */
	                                 threadproc); /* StartRoutine */

	if( status != STATUS_SUCCESS ) {
		free( thread );
		free( info );
		return NULL;
	}

	return thread;
}

FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	/* A wait for the main thread or ourselves will never end
	   also, if we've been detached, we've nothing to wait on
	*/
	if( 
		( thread == NULL ) || 
		( ( thread->flags & ( FBTHREAD_MAIN | FBTHREAD_DETACHED ) ) != 0 ) ||
		( thread == FB_TLSGETCTX( FBTHREAD )->self )
	) {
		return;
	}

	NTWaitForSingleObject( thread->id, FALSE, NULL );
	NtClose( thread->id );
	free( thread );
}
