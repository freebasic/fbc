/* get the executable path */

#include "../fb.h"

char *fb_hGetExePath( char *dst, int maxlen )
{
	const char *p = strrchr( __fb_ctx.argv[0], '/' );
	if( p ) {
		int len = p - __fb_ctx.argv[0];
		if( len > maxlen ) {
			len = maxlen;
		}

		memcpy( dst, __fb_ctx.argv[0], len );
		dst[len] = '\0';
	} else {
		*dst = '\0';
	}
	return dst;
}
