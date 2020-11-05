/* low-level flush system buffers */

#include "../fb.h"
#include <io.h>
#include <windows.h>

int fb_hFileFlushEx( FILE *f )
{
	if( FlushFileBuffers( (HANDLE)get_osfhandle( fileno( f ) ) ) == 0 ) {
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
