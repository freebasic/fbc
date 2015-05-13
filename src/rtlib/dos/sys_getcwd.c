/* get current dir */

#include "../fb.h"
#include <unistd.h>

int fb_hGetCurrentDir( char *dst, int maxlen )
{
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
}
