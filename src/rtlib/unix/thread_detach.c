#include "../fb.h"
#include "../fb_private_thread.h"

FBCALL void fb_ThreadDetach( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	pthread_detach( thread->id );

	free( thread );
}
