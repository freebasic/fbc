/*
 * hook_isredir.c -- input/ouput redirection check
 *
 * chng: dec/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_IsRedirected ( int is_input )
{
	if( __fb_ctx.hooks.isredirproc != NULL )
		return __fb_ctx.hooks.isredirproc( is_input );
	else
		return fb_ConsoleIsRedirected( is_input );
}

