/* console line input function */

#include "../fb.h"
#include "fb_private_console.h"

char *fb_ConsoleReadStr( char *buffer, ssize_t len )
{
	return fgets( buffer, len, stdin );
}
