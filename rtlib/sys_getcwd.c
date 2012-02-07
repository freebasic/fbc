/* get current dir */

#include "fb.h"

int fb_hGetCurrentDir( char *dst, int maxlen )
{
#if defined( HOST_DOS )
	int len, i;
	if( getcwd( dst, maxlen ) != NULL ) {
		len = strlen( dst );
		/* Always return path with native path separator (backslash).
		 * Returning a slash might break compatibility with older sources.
		 */
		for (i=0; i!=len; ++i)
			if (dst[i]=='/')
				dst[i]='\\';
		return len;
	}
	return 0;

#elif defined( HOST_UNIX )
	if( getcwd( dst, maxlen ) != NULL )
		return strlen( dst );
	return 0;

#elif defined( HOST_WIN32 )
	return GetCurrentDirectory( maxlen, dst );

#else
	/* !!!WRITEME!!! */
	*dst = '\0';
	return 0;
#endif
}
