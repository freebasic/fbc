#include "../fb.h"

char *fb_hGetShortPath( char *src, char *dst, ssize_t maxlen )
{
	/* !!!WRITEME!!! */
	strncpy(dst, src, maxlen);
	return dst;
}
