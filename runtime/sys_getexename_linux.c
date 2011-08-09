/* get the executables name for Linux */

#include <malloc.h>
#include <string.h>
#include "fb.h"

#include <unistd.h>
#include <sys/stat.h>
#define MAX_PATH	1024

/*:::::*/
char *fb_hGetExeName( char *dst, int maxlen )
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
		if (p != NULL)
			++p;
		else
			p = dst;
	}
	else
		p = NULL;

	return p;
}
