/*
 * hook_readstr.c -- input$|line input entrypoint, default to console mode
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"
#include <stdio.h>

/*:::::*/
char *fb_ReadString( char *buffer, int len, FILE *f )
{

	if( f != stdin )
		return fgets( buffer, len, f );
	else {
		if( __fb_ctx.hooks.readstrproc )
			return __fb_ctx.hooks.readstrproc( buffer, len );
		else
			return fb_ConsoleReadStr( buffer, len );
	}

}
