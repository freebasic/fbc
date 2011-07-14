/* Windows thread creation and destruction */

#include <process.h>
#include "fb.h"

/* thread proxy to user's thread proc */
#ifdef HOST_MINGW
static unsigned int WINAPI threadproc( void *param )
#else
static DWORD WINAPI threadproc( LPVOID param )
#endif
{
	FBTHREAD *thread = param;

	/* call the user thread */
	thread->proc( thread->param );

	/* free mem */
	fb_TlsFreeCtxTb( );

	return 1;
}

/*:::::*/
FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
{
	FBTHREAD *thread;
#ifdef HOST_MINGW
	unsigned int dwThreadId;
#else
    DWORD dwThreadId;
#endif

	thread = (FBTHREAD *)malloc( sizeof(FBTHREAD) );
	if( thread == NULL )
		return NULL;

    thread->proc	= proc;
    thread->param 	= param;

#ifdef HOST_MINGW
    thread->id = (HANDLE)_beginthreadex( NULL, 
    									 stack_size, 
    									 threadproc, 
    									 (void *)thread, 
    									 0, 
    									 &dwThreadId );
#else
    {
        thread->id = CreateThread( NULL,
                                   stack_size,
                                   threadproc,
                                   (void*)thread,
                                   0,
                                   &dwThreadId );
    }
#endif

    if( thread->id == NULL )
    {
    	free( thread );
    	return NULL;
    }

	return thread;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	WaitForSingleObject( thread->id, INFINITE );

    /* Never forget to close the threads handle ... otherwise we'll
     * have "zombie" threads in the system ... */
    CloseHandle( thread->id );

	free( thread );
}
