/* assertion functions */

#include "fb.h"

#define BUFFER_SIZE 1024

static void hConvToA( char *buffer, FB_WCHAR *expression )
{
	fb_wstr_ConvToA( buffer, BUFFER_SIZE-1, expression );
	buffer[BUFFER_SIZE-1] = 0; /* null terminator */
}

FBCALL void fb_AssertW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	char buffer[BUFFER_SIZE];

	/* Convert the expression wstring to a zstring */
	hConvToA( buffer, expression );

	/* then let the zstring version handle it */
	fb_Assert( filename, linenum, funcname, buffer );

	/* This way we don't need to bother using fwprintf() or similar,
	   which would only make things unnecessarily complex,
	   especially since it doesn't exist on DJGPP. */
}

FBCALL void fb_AssertWarnW( char *filename, int linenum, char *funcname, FB_WCHAR *expression )
{
	char buffer[BUFFER_SIZE];
	hConvToA( buffer, expression );
	fb_AssertWarn( filename, linenum, funcname, buffer );
}
