/* console line input function */

#include "../fb.h"

char *fb_ConsoleReadStr( char *buffer, int len )
{
	return fgets( buffer, len, stdin );
}
