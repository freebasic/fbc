/* put # function for wstrings */

#include "fb.h"

int fb_FilePutWstrEx( FB_FILE *handle, fb_off_t pos, FB_WCHAR *str, ssize_t len )
{
    int res;

	/* perform call ... but only if there's data ... */
    if( (str != NULL) && (len > 0) )
        res = fb_FilePutDataEx( handle, pos, (void *)str, len, TRUE, TRUE, TRUE );
    else
        res = fb_ErrorSetNum( FB_RTERROR_OK );

    return res;
}

FBCALL int fb_FilePutWstr( int fnum, int pos, FB_WCHAR *str, ssize_t str_len )
{
	return fb_FilePutWstrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len);
}

FBCALL int fb_FilePutWstrLarge( int fnum, long long pos, FB_WCHAR *str, ssize_t str_len )
{
	return fb_FilePutWstrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len);
}
