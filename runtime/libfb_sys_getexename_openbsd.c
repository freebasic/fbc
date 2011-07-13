/*
 * sys_getexename.c -- get the executable's name for OpenBSD
 *
 * chng: sep/2007 written [DrV]
 *
 */

#include "fb.h"
#include <string.h>

/*:::::*/
char *fb_hGetExeName( char *dst, int maxlen )
{
	const char *p;

	p = strrchr( __fb_ctx.argv[0], '/' );
	if( p )
	{
		strlcpy( dst, p + 1, maxlen );
	}
	else
	{
		strlcpy( dst, __fb_ctx.argv[0], maxlen );
	}

	return dst;
}
