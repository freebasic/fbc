/* assertion functions */

#include "fb.h"

FBCALL void fb_AssertW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	fb_AssertWarnW( filename, linenum, funcname, expression );
	fb_End( 1 );
}

FBCALL void fb_AssertWarnW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	/* Printing to stderr, like fb_Die() */
	fwprintf( stderr, _LC("%S(%d): assertion failed at %S: %s\n"),
	          filename, linenum, funcname, expression );
}
