/* thread creation and destruction functions */

#include "../fb.h"
#include "../fb_private_thread.h"

FBCALL FBTHREAD *fb_ThreadCreate( FB_THREADPROC proc, void *param, ssize_t stack_size )
{
	FBTHREAD *thread;

	thread = (FBTHREAD *)malloc( sizeof( FBTHREAD ) );
	if( thread == NULL ) {
		return NULL;
	}

	return thread;
}

FBCALL void fb_ThreadWait( FBTHREAD *thread )
{
	if( !thread )
		return;

	free( thread );
}
