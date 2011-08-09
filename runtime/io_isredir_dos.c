/* console redirection check */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "fb.h"

/*:::::*/
int fb_ConsoleIsRedirected( int is_input )
{
	return isatty( fileno( (is_input? stdin : stdout) ) ) == 0;
}


