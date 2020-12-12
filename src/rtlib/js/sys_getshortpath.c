#include "../fb.h"

char *fb_hGetShortPath( char *src, char *dst, ssize_t maxlen )
{
	strncpy(dst, src, maxlen);
	return dst;
}
