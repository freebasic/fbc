/* assertion functions */

#include "fb.h"

/*:::::*/
static void printmsg( char *filename, int linenum, char *funcname, char *expression )
{
	char buffer[1024];

	snprintf( buffer, 1024, "%s(%d): assertion failed at %s: %s", filename, linenum, funcname, expression );

	fb_PrintFixString( 0, buffer, FB_PRINT_NEWLINE );
}

/*:::::*/
FBCALL void fb_Assert( char *filename, int linenum, char *funcname, char *expression )
{
	printmsg( filename, linenum, funcname, expression );

	fb_End( 1 );
}

/*:::::*/
FBCALL void fb_AssertWarn( char *filename, int linenum, char *funcname, char *expression )
{
	printmsg( filename, linenum, funcname, expression );
}
