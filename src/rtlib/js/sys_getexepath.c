/* get the executable path */

#include "../fb.h"

char *fb_hGetExePath( char *dst, ssize_t maxlen )
{
	/* There is no executable, but return a valid path: / */
	dst[0] = '/';
	dst[1] = '\0';
	return dst;
}
