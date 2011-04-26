/*
 * thread_core.c -- DOS thread creation and destruction (empty)
 *
 * chng: feb/2005 written [DrV]
 *
 */


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
