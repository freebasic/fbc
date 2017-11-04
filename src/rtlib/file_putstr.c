/* put # function for strings */

#include "fb.h"

int fb_FilePutStrEx( FB_FILE *handle, fb_off_t pos, void *str, ssize_t str_len )
{
	int res;
	ssize_t len;
    char *data;

    /* get string data len */
	FB_STRSETUP_DYN( str, str_len, data, len );

	/* perform call ... but only if there's data ... */
    if( (data != NULL) && (len > 0) )
        res = fb_FilePutDataEx( handle, pos, data, len, TRUE, TRUE, FALSE );
    else
    	res = fb_ErrorSetNum( FB_RTERROR_OK );

    /* del if temp */
    if( str_len == -1 )
        fb_hStrDelTemp( (FBSTRING *)str );

    return res;
}

FBCALL int fb_FilePutStr( int fnum, int pos, void *str, ssize_t str_len )
{
	return fb_FilePutStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len);
}

FBCALL int fb_FilePutStrLarge( int fnum, long long pos, void *str, ssize_t str_len )
{
	return fb_FilePutStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len);
}
