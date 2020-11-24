/* thread creation and destruction functions */

#include "../fb.h"
#include "../fb_private_thread.h"
#include <process.h>

/* thread proxy to user's thread proc */
#ifdef HOST_MINGW
static unsigned int WINAPI threadproc( void *param )
#else
static DWORD WINAPI threadproc( LPVOID param )
#endif
{
	FBTHREADINFO *info = param;
	FBTHREAD *thread = info->thread;
	FBTHREADFLAGS flags;

	FB_TLSGETCTX( FBTHREAD )->self = thread;

	/* call the user thread */
	info->proc( info->param );
	free( info );

	/* free mem */
	fb_TlsFreeCtxTb( );

	flags = fb_AtomicSetThreadFlags( &thread->flags, FBTHREAD_EXITED );

	/* This thread has been detached, we can free the thread structure */
	if( flags & FBTHREAD_DETACHED ) {
		free( thread );
	}

	return 1;
}

FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, ssize_t stack_size )
{
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

#ifdef HOST_MINGW
	/* Note: _beginthreadex()'s last parameter cannot be NULL,
	   or else the function fails on Windows 9x */
	unsigned int thrdaddr;
	thread->id = (HANDLE)_beginthreadex( NULL, stack_size, threadproc, info, 0, &thrdaddr );
#else
	DWORD dwThreadId;
	thread->id = CreateThread( NULL, stack_size, threadproc, info, 0, &dwThreadId );
#endif

	if( thread->id == NULL ) {
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

	WaitForSingleObject( thread->id, INFINITE );

	/* Never forget to close the threads handle ... otherwise we'll
	 * have "zombie" threads in the system ... */
	CloseHandle( thread->id );

	free( thread );
}
