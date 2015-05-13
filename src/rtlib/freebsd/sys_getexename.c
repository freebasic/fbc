/* get the executable's name */

#include "../fb.h"

char *fb_hGetExeName( char *dst, ssize_t maxlen )
{
	const char *p = strrchr( __fb_ctx.argv[0], '/' );
	if( p )
		strlcpy( dst, p + 1, maxlen );
	else
		strlcpy( dst, __fb_ctx.argv[0], maxlen );
	return dst;
}
