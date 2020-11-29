#include "../fb.h"
#include "../fb_private_thread.h"

FBCALL void fb_ThreadDetach( FBTHREAD *thread )
{
	FBTHREADFLAGS flags;

	if( thread == NULL || ( thread->flags & FBTHREAD_MAIN ) )
		return;

	flags = fb_AtomicSetThreadFlags( &thread->flags, FBTHREAD_DETACHED );
	NtClose( thread->id );

	if( flags & FBTHREAD_EXITED ) {
		free( thread );
	}
}
