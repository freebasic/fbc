/* get # function for strings */

#include "fb.h"

int fb_FileGetStrEx( FB_FILE *handle, fb_off_t pos, void *str, ssize_t str_len, size_t *bytesread )
{
    int res;
    size_t len;
	char *data;

	if( bytesread )
		*bytesread = 0;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    /* get string len */
	FB_STRSETUP_DYN( str, str_len, data, len );

	/* perform call ... but only if there's data ... */
    if( (data != NULL) && (len > 0) ) {
        res = fb_FileGetDataEx( handle, pos, data, len, &len, TRUE, FALSE );
        data[len] = 0;                                /* add the null-term */
    } else {
		/* no/empty destination string */
		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	if( bytesread )
		*bytesread = len;

	/* del if temp */
	if( str_len == -1 )
		fb_hStrDelTemp( (FBSTRING *)str );		/* will free the temp desc if fix-len passed */

	return res;
}

FBCALL int fb_FileGetStr( int fnum, int pos, void *str, ssize_t str_len )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, NULL);
}

FBCALL int fb_FileGetStrLarge( int fnum, long long pos, void *str, ssize_t str_len )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, NULL);
}

FBCALL int fb_FileGetStrIOB( int fnum, int pos, void *str, ssize_t str_len, size_t *bytesread )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, bytesread);
}

FBCALL int fb_FileGetStrLargeIOB( int fnum, long long pos, void *str, ssize_t str_len, size_t *bytesread )
{
	return fb_FileGetStrEx(FB_FILE_TO_HANDLE(fnum), pos, str, str_len, bytesread);
}
