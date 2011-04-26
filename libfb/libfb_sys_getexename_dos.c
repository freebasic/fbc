/*
 * sys_getexename.c -- get the executable's name for DOS
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include "fb.h"

/*:::::*/
char *fb_hGetExeName( char *dst, int maxlen )
{
	char *p;

	strncpy(dst, __fb_ctx.argv[0], maxlen);

	p = strrchr( dst, '\\' );
	if( p != NULL )
		++p;
	else
		p = dst;

	return p;
}

