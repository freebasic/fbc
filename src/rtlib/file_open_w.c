/* open and core file functions (wide string) */

#include "fb.h"

int fb_FileOpenEx_W( FB_FILE *handle, FB_WCHAR *str, unsigned int mode,
                   unsigned int access, unsigned int lock, int len )
{
    return fb_FileOpenVfsEx_W( handle, str, mode, access, lock, len,
                             FB_FILE_ENCOD_DEFAULT, fb_DevFileOpen_W );
}

FBCALL int fb_FileOpen_W( FB_WCHAR *str, unsigned int mode, unsigned int access,
                        unsigned int lock, int fnum, int len )
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    return fb_FileOpenEx_W( FB_FILE_TO_HANDLE(fnum), str, mode, access, lock, len );
}
