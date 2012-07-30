/* get the executable's name */

#include "../fb.h"

char *fb_hGetExeName( char *dst, int maxlen )
{
	strncpy(dst, __fb_ctx.argv[0], maxlen);
	char *p = strrchr( dst, '\\' );
	if( p != NULL )
		++p;
	else
		p = dst;
	return p;
}
