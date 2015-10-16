/* low-level print to console function */

#include "../fb.h"

void fb_ConsolePrintBufferWstrEx
	(
		const FB_WCHAR *buffer,
		size_t chars,
		int mask
	)
{
	/* !!!FIXME!!! should print only buffer[0 .. chars-1] */
	wprintf( L"%ls", buffer );
}

void fb_ConsolePrintBufferWstr
	(
		const FB_WCHAR *buffer,
		int mask
	)
{
	return fb_ConsolePrintBufferWstrEx( buffer, fb_wstr_Len( buffer ), mask );
}
