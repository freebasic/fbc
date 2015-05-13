/* assertion functions */

#include "fb.h"

FBCALL void fb_PrintWstr ( int fnum, const FB_WCHAR *s, int mask );

/*:::::*/
static void printmsg( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	FB_WCHAR buffer[1024];

	swprintf( buffer, 1024, _LC("%S(%d): assertion failed at %S: %s"),
			  filename, linenum, funcname, expression );

	fb_PrintWstr( 0, buffer, FB_PRINT_NEWLINE );
}

/*:::::*/
FBCALL void fb_AssertW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	printmsg( filename, linenum, funcname, expression );

	fb_End( 1 );
}

/*:::::*/
FBCALL void fb_AssertWarnW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	printmsg( filename, linenum, funcname, expression );
}
