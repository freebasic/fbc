/* assertion functions */

#include "fb.h"

FBCALL void fb_Assert( char *filename, int linenum, char *funcname, char *expression )
{
	fb_AssertWarn( filename, linenum, funcname, expression );
	fb_End( 1 );
}

FBCALL void fb_AssertWarn( char *filename, int linenum, char *funcname, char *expression )
{
	/* Printing to stderr, like fb_Die() */
	fprintf( stderr, "%s(%d): assertion failed at %s: %s\n",
	         filename, linenum, funcname, expression );
}
