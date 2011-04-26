/*
 * io_isredir - console redirection check
 *
 * chng: dec/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
int fb_ConsoleIsRedirected( int is_input )
{
	return isatty( fileno( (is_input? stdin : stdout) ) ) == 0;
}


