/* chdir function */

#include "fb.h"
#ifdef HOST_MINGW
#include <direct.h>
#else
#include <unistd.h>
#endif

FBCALL int fb_ChDir( FBSTRING *path )
{
	int res;

#ifdef HOST_MINGW
	res = _chdir( path->data );
#else
	res = chdir( path->data );
#endif

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
