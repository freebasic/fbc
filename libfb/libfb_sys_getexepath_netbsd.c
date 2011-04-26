/*
 * sys_getexepath.c -- get the executable path for NetBSD
 *
 * chng: sep/2007 written [DrV]
 *
 */

#include "fb.h"
#include <string.h>

/*:::::*/
char *fb_hGetExePath( char *dst, int maxlen )
{
	const char *p;

	p = strrchr( __fb_ctx.argv[0], '/' );
	if( p )
	{
		int len;

		len = p - __fb_ctx.argv[0];
		if( len > maxlen )
		{
			len = maxlen;
		}

		memcpy( dst, __fb_ctx.argv[0], len );
		dst[len] = '\0';
	}
	else
	{
		*dst = '\0';
	}

	return dst;
}
