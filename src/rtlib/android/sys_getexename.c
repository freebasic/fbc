/* get the executable's name */

#include "../fb.h"
#include <sys/stat.h>

char *fb_hGetExeName( char *dst, ssize_t maxlen )
{
	char *p;
	char linkname[1024];
	struct stat finfo;
	ssize_t len;

	sprintf(linkname, "/proc/%d/exe", getpid());
	if ((stat(linkname, &finfo) == 0) && ((len = readlink(linkname, dst, maxlen - 1)) > -1)) {
		/* Linux-like proc fs is available */
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
