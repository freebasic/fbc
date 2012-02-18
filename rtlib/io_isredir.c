/* console redirection check */

#include "fb.h"
#if defined HOST_DOS
	#include <unistd.h>
#elif defined HOST_WIN32
	#include "fb_private_console.h"
#endif

int fb_ConsoleIsRedirected( int is_input )
{
#if defined( HOST_WIN32 )
	DWORD mode;
	return (GetConsoleMode( (is_input? __fb_in_handle : __fb_out_handle), &mode ) == 0);
#elif defined( HOST_XBOX )
	return TRUE;
#else
	return (isatty( fileno( (is_input? stdin : stdout) ) ) == 0);
#endif
}
