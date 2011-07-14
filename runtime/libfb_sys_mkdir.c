/* mkdir function */

#include "fb.h"
#ifdef HOST_MINGW
#include <dir.h>
#else
#include <sys/stat.h>
#endif

/*:::::*/
FBCALL int fb_MkDir( FBSTRING *path )
{
	int res;

	res = mkdir( path->data, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH );

	/* del if temp */
	fb_hStrDelTemp( path );

	return res;
}
