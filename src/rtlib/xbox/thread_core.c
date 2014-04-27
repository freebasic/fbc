/* thread creation and destruction functions */

#include "../fb.h"
#include "../fb_private_thread.h"
#include <xboxkrnl/xboxkrnl.h>

static void NTAPI threadproc(void *param1, void *param2)
{
	FBTHREADINFO *info = param1;

	/* call the user thread procedure */
	info->proc( info->param );
	free( info );

	/* free mem */
	fb_TlsFreeCtxTb( );
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

	return NULL;
}

FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( !thread )
		return;

	NTWaitForSingleObject( thread->id, FALSE, NULL );
	NtClose( thread->id );
	free( thread );
}
