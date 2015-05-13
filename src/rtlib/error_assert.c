/* assertion functions */

#include "fb.h"

FBCALL void fb_Assert( char *filename, int linenum, char *funcname, char *expression )
{
	snprintf( __fb_errmsg, FB_ERRMSG_SIZE,
	          "%s(%d): assertion failed at %s: %s\n",
	          filename, linenum, funcname, expression );

	__fb_errmsg[FB_ERRMSG_SIZE-1] = '\0';

	/* Let fb_hRtExit() show the message */
	__fb_ctx.errmsg = __fb_errmsg;

	fb_End( 1 );
}

FBCALL void fb_AssertWarn( char *filename, int linenum, char *funcname, char *expression )
{
	/* Printing to stderr, as done with assert() or runtime error messages
	   in fb_hRtExit() */
	fprintf( stderr, "%s(%d): assertion failed at %s: %s\n",
	         filename, linenum, funcname, expression );
}
