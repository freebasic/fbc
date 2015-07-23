/* get the executable's name */

#include "../fb.h"
#include "sys/sysctl.h"

char *fb_hGetExeName( char *dst, ssize_t maxlen )
{
	size_t len = maxlen;
	char *p;
	int mib[4];
	mib[0] = CTL_KERN;
	mib[1] = KERN_PROC;
	mib[2] = KERN_PROC_PATHNAME;
	mib[3] = -1;
	
	if (sysctl(mib, 4, dst, &len, NULL, 0) == 0) {
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
