/*
 * sys_rmdir.c -- rmdir function
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
FBCALL int fb_RmDir( FBSTRING *path )
{
	int res;

	res = rmdir( path->data );

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
