/* get the executable path */

#include "../fb.h"
#include <sys/stat.h>

char *fb_hGetExePath( char *dst, int maxlen )
{
	char *p;
	char linkname[1024];
	struct stat finfo;
	int len;

	sprintf(linkname, "/proc/%d/exe", getpid());
	if ((stat(linkname, &finfo) == 0) && ((len = readlink(linkname, dst, maxlen - 1)) > -1)) {
		/* Linux-like proc fs is available */
		dst[len] = '\0';
		p = strrchr(dst, '/');
		if (p)
			*p = '\0';
		else
			dst[0] = '\0';
	} else {
		p = NULL;
	}

	return p;
}
