/* get the executable's name */

#include "../fb.h"
#include <sys/stat.h>

char *fb_hGetExeName( char *dst, ssize_t maxlen )
{
	char *p;
	struct stat finfo;
	ssize_t len;
	
	if ((stat("/proc/curproc/exe", &finfo) == 0) && ((len = readlink("/proc/curproc/exe", dst, maxlen - 1)) > -1)) {
		/* NetBSD-like proc fs is available */
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
