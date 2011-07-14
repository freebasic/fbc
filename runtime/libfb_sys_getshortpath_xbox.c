/* get short path for xbox */

#include <malloc.h>
#include <string.h>

#include "../fb.h"

/* !!!FIXME!!! */

/*:::::*/
char *fb_hGetShortPath( char *src, char *dst, int maxlen )
{
	strncpy(dst, src, maxlen);
	return dst;
}

