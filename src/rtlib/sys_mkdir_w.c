/* mkdir function */

#include "fb.h"
#ifdef HOST_MINGW
#include <direct.h>
#else
#include <sys/stat.h>
#endif

/*:::::*/
FBCALL int fb_MkDir_W( FB_WCHAR *path )
{
	int res = -1;

#ifdef HOST_MINGW
	res = _wmkdir( path );
#else
    char *pathname;
    ssize_t bytes;
    size_t pathname_length;

    pathname_length = fb_wstr_Len( path );
    pathname = fb_WCharToUTF( FB_FILE_ENCOD_UTF8,
                              path,
                              pathname_length,
                              NULL,
                              &bytes );

    if ( pathname != NULL )
    {
  	    res = mkdir( pathname, S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH );
        free( pathname );
    }
#endif

	return res;
}
