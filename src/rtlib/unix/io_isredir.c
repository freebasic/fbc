#include "../fb.h"

int fb_ConsoleIsRedirected( int is_input )
{
	return (isatty( fileno( (is_input ? stdin : stdout) ) ) == 0) ? FB_TRUE : FB_FALSE;
}
