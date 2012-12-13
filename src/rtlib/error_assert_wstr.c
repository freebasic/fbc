/* assertion functions */

#include "fb.h"

#define BUFFER_LENGTH 511

FBCALL void fb_AssertW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	fb_AssertWarnW( filename, linenum, funcname, expression );
	fb_End( 1 );
}

FBCALL void fb_AssertWarnW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	char buffer[BUFFER_LENGTH+1];

	/* Convert expression wstring to zstring */
	fb_wstr_ConvToA( buffer, expression, BUFFER_LENGTH );
	buffer[BUFFER_LENGTH] = 0; /* null terminator */

	/* then let the zstring version print it */
	fb_AssertWarn( filename, linenum, funcname, buffer );

	/* This way we don't need to bother using fwprintf() or similar,
	   which would only make things unnecessarily complex,
	   especially since it doesn't exist on DJGPP. */
}
