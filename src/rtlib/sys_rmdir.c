/* rmdir function */

#include "fb.h"
#ifdef HOST_MINGW
#include <direct.h>
#else
#include <unistd.h>
#endif

/*:::::*/
FBCALL int fb_RmDir( FBSTRING *path )
{
	int res;

#ifdef HOST_MINGW
	res = _rmdir( path->data );
#else
	res = rmdir( path->data );
#endif

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
