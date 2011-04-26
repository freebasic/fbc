/*
 * file_convpath - path conversion for Linux
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

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
		if ( path[i] == '\\' )
			path[i] = '/';
	}

	return path;
}

