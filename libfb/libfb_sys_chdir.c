/*
 * sys_chdir.c -- chdir function
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"
#ifdef TARGET_WIN32
#include <dir.h>
#else
#include <unistd.h>
#endif

/*:::::*/
FBCALL int fb_ChDir( FBSTRING *path )
{
	int res;

	res = chdir( path->data );

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
