/* low-level lock and unlock functions */

#include "../fb.h"
#include <io.h>
#include <windows.h>

int fb_hFileLock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	return fb_ErrorSetNum( LockFile( (HANDLE)get_osfhandle( fileno( f ) ), inipos, 0, size, 0 ) == TRUE ?
	                       FB_RTERROR_OK : FB_RTERROR_FILEIO );
}

int fb_hFileUnlock( FILE *f, fb_off_t inipos, fb_off_t size )
{
	return fb_ErrorSetNum( UnlockFile( (HANDLE)get_osfhandle( fileno( f ) ), inipos, 0, size, 0 ) == TRUE ?
	                       FB_RTERROR_OK : FB_RTERROR_FILEIO );
}
