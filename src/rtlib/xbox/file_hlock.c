/* low-level lock and unlock functions */

#include "../fb.h"

int fb_hFileLock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
}

int fb_hFileUnlock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	return fb_ErrorSetNum( FB_RTERROR_FILEIO );
}
