/* input/ouput redirection check */

#include "fb.h"

FBCALL int fb_IsRedirected ( int is_input )
{
	int result;

	FB_LOCK( );

	if( __fb_ctx.hooks.isredirproc != NULL )
		result = __fb_ctx.hooks.isredirproc( is_input );
	else
		result = fb_ConsoleIsRedirected( is_input );

	FB_UNLOCK( );

	return result;
}
