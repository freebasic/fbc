/* rmdir function */

#include "fb.h"
#ifdef HOST_MINGW
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
