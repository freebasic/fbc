/* get # function for wstrings */

#include "fb.h"

int fb_FileGetWstrEx
	(
		FB_FILE *handle,
		fb_off_t pos,
		FB_WCHAR *dst,
		ssize_t dst_chars,
		size_t *bytesread
	)
{
    int res;

	if( bytesread )
		*bytesread = 0;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* perform call ... but only if there's data ... */
    if( (dst != NULL) && (dst_chars > 0) )
    {
        size_t chars;
        res = fb_FileGetDataEx( handle, pos, (void *)dst, dst_chars, &chars, TRUE, TRUE );

        /* add the null-term */
        if( res == FB_RTERROR_OK )
        	dst[chars] = _LC('\0');

		if( bytesread )
			*bytesread = chars * sizeof(FB_WCHAR);
    }
    else
		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	return res;
}

FBCALL int fb_FileGetWstr( int fnum, int pos, FB_WCHAR *dst, ssize_t dst_chars )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, NULL );
}

FBCALL int fb_FileGetWstrLarge( int fnum, long long pos, FB_WCHAR *dst, ssize_t dst_chars )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, NULL );
}

FBCALL int fb_FileGetWstrIOB( int fnum, int pos, FB_WCHAR *dst, ssize_t dst_chars, size_t *bytesread )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, bytesread );
}

FBCALL int fb_FileGetWstrLargeIOB( int fnum, long long pos, FB_WCHAR *dst, ssize_t dst_chars, size_t *bytesread )
{
	return fb_FileGetWstrEx( FB_FILE_TO_HANDLE(fnum), pos, dst, dst_chars, bytesread );
}
