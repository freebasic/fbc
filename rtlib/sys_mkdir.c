/* mkdir function */

#include "fb.h"
#ifdef HOST_MINGW
#include <direct.h>
#else
#include <sys/stat.h>
#endif

/*:::::*/
FBCALL int fb_MkDir( FBSTRING *path )
{
	int res;

#ifdef HOST_MINGW
	res = _mkdir( path->data );
#else
	res = mkdir( path->data, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH );
#endif

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
