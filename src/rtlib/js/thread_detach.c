#include "../fb.h"

FBCALL void fb_ThreadDetach( FBTHREAD *thread )
{
	if( thread == NULL )
		return;

	free( thread );
}
