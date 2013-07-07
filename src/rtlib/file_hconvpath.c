/* path conversion */

#include "fb.h"

void fb_hConvertPath( char *path )
{
	ssize_t i, len;

	DBG_ASSERT( path != NULL );

	len = strlen( path );
	for (i = 0; i < len; i++)
	{
#if defined( HOST_DOS ) || defined( HOST_MINGW ) || defined( HOST_XBOX )
		if( path[i] == '/' )
			path[i] = '\\';
#else
		if( path[i] == '\\' )
			path[i] = '/';
#endif
	}
}
