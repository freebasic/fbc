/*
 * sys_getshorpath.c -- get short path for xbox
 *
 * chng: jul/2005 written []
 *
 */

#include <malloc.h>
#include <string.h>

#include "../fb.h"

/* !!!FIXME!!! */

/*:::::*/
char *fb_hGetShortPath( char *src, char *dst, int maxlen )
{
	strncpy(dst, src, maxlen);	
	return dst;
}

