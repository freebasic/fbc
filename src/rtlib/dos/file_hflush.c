/* flush system buffers */

#include "../fb.h"
#include <unistd.h>

int fb_hFileFlushEx( FILE *f )
{
	if( fsync( fileno( f ) ) != 0 ) {
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
