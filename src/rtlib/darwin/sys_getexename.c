/* get the executable's name */

#include "../fb.h"
#include "mach-o/dyld.h"

char *fb_hGetExeName( char *dst, ssize_t maxlen )
{
	char *p;
	uint32_t len = maxlen;

	if (_NSGetExecutablePath(dst, &len) == 0) {
		dst[len] = '\0';
		p = strrchr(dst, '/');
		if (p != NULL)
			++p;
		else
			p = dst;
	} else {
		p = NULL;
	}

	return p;
}
