/* get the executable path */

#include "../fb.h"
#include <sys/stat.h>

char *fb_hGetExePath( char *dst, ssize_t maxlen )
{
	char *p;
	struct stat finfo;
	ssize_t len;

	if ((stat("/proc/self/exe", &finfo) == 0) && ((len = readlink("/proc/self/exe", dst, maxlen - 1)) > -1)) {
		/* Linux-like proc fs is available */
		dst[len] = '\0';
		p = strrchr(dst, '/');
		if (p == dst) /* keep the "/" rather than returning "" */
			*(p + 1) = '\0';
		else if (p)
			*p = '\0';
		else
			dst[0] = '\0';
	} else {
		p = NULL;
	}

	return p;
}
