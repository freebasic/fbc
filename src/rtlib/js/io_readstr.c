/* console line input function */

#include "../fb.h"

char *fb_ConsoleReadStr( char *buffer, ssize_t len )
{
	return fgets( buffer, len, stdin );
}
