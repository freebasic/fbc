/* low-level truncate / set end of file */

#include "../fb.h"
#include <io.h>

/*
    rely on mingw-w64 having FTRUNCATE_DEFINED defined
    to let us know that ftruncate64 is defined.

    Otherwise, just call the windows API SetEndOfFile

    Perhaps in an updated version of mingw(org) we can
    remove the conditional compilation here and use
    only ftruncate/ftruncate64.  Would be nice if mingw
    supports _FILE_OFFSET_BITS in a later version than
    our current setup
*/

#if defined( FTRUNCATE_DEFINED )
#include <unistd.h>
#else
#include <windows.h>
#endif

int fb_hFileSetEofEx( FILE *f )
{

#if defined( FTRUNCATE_DEFINED )
	fb_off_t pos;
	pos = ftello( f );
	if( ftruncate64( fileno(f), pos ) != 0 ) {
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}
#else
	if( SetEndOfFile( (HANDLE)get_osfhandle( fileno( f ) ) ) == 0 ) {
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}
#endif

	return fb_ErrorSetNum( FB_RTERROR_OK );
	
}
