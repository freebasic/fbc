/* low-level print to console function stub */

#include "../fb.h"

void fb_ConsolePrintBufferEx( const void *buffer, size_t len, int mask )
{
}

void fb_ConsolePrintBuffer( const char *buffer, int mask )
{
	fb_ConsolePrintBufferEx( buffer, strlen(buffer), mask );
}
