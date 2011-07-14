/* DOS thread creation and destruction (empty) */

#include "fb.h"

/*:::::*/
FBCALL FBTHREAD	*fb_ThreadCreate( FB_THREADPROC proc, void *param, int stack_size )
{
	return NULL;
}

/*:::::*/
FBCALL void fb_ThreadWait( FBTHREAD	*thread )
{
	/* */
}
