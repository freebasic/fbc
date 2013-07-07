/* get current dir */

#include "../fb.h"
#include <unistd.h>

ssize_t fb_hGetCurrentDir( char *dst, ssize_t maxlen )
{
	ssize_t len, i;
	if( getcwd( dst, maxlen ) != NULL ) {
		len = strlen( dst );
		/* Always return path with native path separator (backslash).
		 * Returning a slash might break compatibility with older sources.
		 */
		for (i=0; i!=len; ++i)
			if (dst[i]=='/')
				dst[i]='\\';

		/* make drive letter uppercase */
		if( dst[1] == ':' )
			dst[0] = toupper( dst[0] );

		return len;
	}
	return 0;
}
