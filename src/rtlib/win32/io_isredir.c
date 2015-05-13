#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleIsRedirected( int is_input )
{
	DWORD mode;
	return (GetConsoleMode( (is_input ? __fb_in_handle : __fb_out_handle), &mode ) == 0) ? FB_TRUE : FB_FALSE;
}
