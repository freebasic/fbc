/* get the executable path */

#include "../fb.h"
#include "sys/sysctl.h"

char *fb_hGetExePath( char *dst, ssize_t maxlen )
{
	size_t length = maxlen;
	char *p;
	int mib[4];
	mib[0] = CTL_KERN;
	mib[1] = KERN_PROC;
	mib[2] = KERN_PROC_PATHNAME;
	mib[3] = -1;
	
	if (sysctl(mib, 4, dst, &length, NULL, 0) == 0) {
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
