/* thread creation and destruction functions */

#include "../fb.h"
#include "../fb_private_thread.h"
#include <xboxkrnl/xboxkrnl.h>

static void NTAPI threadproc(void *param1, void *param2)
{
#if 0
	FBTHREAD *thread = param1;
	
	/* call the user thread procedure */
	thread->proc( thread->param );
	
	/* free mem */
	fb_TlsFreeCtxTb( );
#endif
}

FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
{
	NTSTATUS status;
	FBTHREAD *thread;

	thread = malloc( sizeof( FBTHREAD ) );

	if ( !thread )
		return NULL;

	thread->proc = proc;
	thread->param = param;

	status = PsCreateSystemThreadEx( &thread->id, /* ThreadHandle */
	                                 0,           /* ThreadExtraSize */
	                                 /* stack_size??? */ 65536,       /* KernelStackSize */
	                                 0,           /* TlsDataSize */
	                                 NULL,        /* ThreadId */
	                                 &thread,     /* StartContext1 */
	                                 NULL,        /* StartContext2 */
	                                 FALSE,       /* CreateSuspended */
	                                 FALSE,       /* DebugStack */
	                                 threadproc); /* StartRoutine */

	if( status != STATUS_SUCCESS ) {
		free( thread );
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
