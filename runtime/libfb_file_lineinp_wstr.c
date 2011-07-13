/*
 * file_lineinput_wstr - line input function for wstrings
 *
 * chng: nov/2005 written [v1ctor]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_FileLineInputWstr( int fnum, FB_WCHAR *dst, int max_chars )
{
    FB_FILE *handle = FB_FILE_TO_HANDLE(fnum);

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    if( handle->hooks->pfnReadLineWstr == NULL )
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    return handle->hooks->pfnReadLineWstr( handle, dst, max_chars );
}

