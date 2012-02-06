/* path conversion for xbox */

#include <string.h>
#include "fb.h"

/*:::::*/
void fb_hConvertPath( char *path )
{
    int i;

	if( path == NULL )
		return;

	int len = strlen( path );
	for (i = 0; i < len; i++)
	{
		if ( path[i] == '/' )
			path[i] = '\\';
	}
}
