/* console line input function for DOS */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
char *fb_ConsoleReadStr( char *buffer, int len )
{

	return fgets( buffer, len, stdin );

}

