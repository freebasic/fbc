/* path conversion for Windows */

#include <string.h>
#include "fb.h"

/*:::::*/
char *fb_hConvertPath( char *path, int len )
{
    int i;

    if( path == NULL )
    	return NULL;

    len = strlen( path );
	for (i = 0; i < len; i++)
    {
#ifdef HOST_CYGWIN
		if ( path[i] == '\\' )
            path[i] = '/';
#else
		if ( path[i] == '/' )
            path[i] = '\\';
#endif
	}

	return path;
}
