#include "../fb.h"

char *fb_hGetShortPath( char *src, char *dst, ssize_t maxlen )
{
	if( strchr( src, 32 ) == NULL ) {
		strncpy( dst, src, maxlen );
		dst[maxlen - 1] = 0;
	} else {
		ssize_t i = 0;
		char *old_dst = dst;
		while ((*src) && (i < maxlen - 1)) {
			if (*src == ' ') {
				*dst++ = '\\';
				i++;
				if (i >= maxlen - 1)
					break;
			}
			*dst++ = *src++;
			i++;
		}
		*dst = 0;
		dst = old_dst;
	}
	return dst;
}
