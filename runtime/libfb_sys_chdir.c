/* chdir function */

#include "fb.h"
#ifdef HOST_MINGW
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
