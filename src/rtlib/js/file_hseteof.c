/* low-level truncate / set end of file */

#include "../fb.h"
#include <unistd.h>

int fb_hFileSetEofEx( FILE *f )
{
	fb_off_t pos;

	pos = ftello( f );
	if( ftruncate( fileno(f), pos ) != 0 ) {
		return fb_ErrorSetNum( FB_RTERROR_FILEIO );
	}

	return fb_ErrorSetNum( FB_RTERROR_OK );
	
}
