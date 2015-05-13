#include "../fb.h"
#include "../fb_private_thread.h"

FBCALL void fb_ThreadDetach( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	CloseHandle( thread->id );

	free( thread );
}
