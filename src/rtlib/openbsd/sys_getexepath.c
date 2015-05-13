/* get the executable path */

#include "../fb.h"

char *fb_hGetExePath( char *dst, ssize_t maxlen )
{
	const char *p = strrchr( __fb_ctx.argv[0], '/' );
	if( p ) {
		ssize_t len = p - __fb_ctx.argv[0];
		if( len > maxlen ) {
			len = maxlen;
		}
		else if( len == 0 ) {
		/* keep the "/" rather than returning "" */
			len = 1;
		}

		memcpy( dst, __fb_ctx.argv[0], len );
		dst[len] = '\0';
	} else {
		*dst = '\0';
	}
	return dst;
}
