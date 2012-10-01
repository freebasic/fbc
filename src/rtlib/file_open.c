/* open and core file functions */

#include "fb.h"

int fb_FileOpenEx( FB_FILE *handle, FBSTRING *str, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
	return fb_FileOpenVfsEx( handle, str, mode, access, lock, len,
	                         FB_FILE_ENCOD_DEFAULT, fb_DevFileOpen );
}

FBCALL int fb_FileOpen( FBSTRING *str, unsigned int mode, unsigned int access,
                        unsigned int lock, int fnum, int len )
{
	if( !FB_FILE_INDEX_VALID( fnum ) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	return fb_FileOpenEx( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}
