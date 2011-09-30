/* open SCRN */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileOpenScrn ( FBSTRING *str_filename, unsigned int mode,
                             unsigned int access, unsigned int lock,
                             int fnum, int len, const char *encoding )
{
    if( !FB_FILE_INDEX_VALID( fnum ) )
    	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    fb_DevScrnInit( );

    return fb_FileOpenVfsEx( FB_FILE_TO_HANDLE(fnum),
                             str_filename,
                             mode,
                             access,
                             lock,
                             len,
                             fb_hFileStrToEncoding( encoding ),
                             fb_DevScrnOpen );
}
