/* chdir function (wide string) */

#include "fb.h"
#ifdef HOST_MINGW
#include <direct.h>
#else
#include <unistd.h>
#endif

FBCALL int fb_ChDir_W( FB_WCHAR *path )
{
	int res = -1;

#ifdef HOST_MINGW
	res = _wchdir( path );

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
        res = chdir( pathname );
        free( pathname );
    }
#endif

	return res;
}
