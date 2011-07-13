/*
 * sys_getcwd.c -- get current dir for Windows
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
int fb_hGetCurrentDir ( char *dst, int maxlen )
{

	return GetCurrentDirectory( maxlen, dst );

}
