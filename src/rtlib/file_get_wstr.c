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

	if( (dst != NULL) && (dst_chars > 0) ) {
		if (dst_chars > 1) {
			/* read dst_chars - 1 chars, then add null-terminator */
			size_t chars;
			res = fb_FileGetDataEx( handle, pos, (void *)dst, dst_chars - 1, &chars, TRUE, TRUE );
			if (res == FB_RTERROR_OK) {
				dst[chars] = _LC('\0'); /* null-terminator */
				if (bytesread)
					*bytesread = chars * sizeof(FB_WCHAR);
			}
		} else {
			/* room for null-terminator only */
			dst[0] = _LC('\0');
			res = FB_RTERROR_OK;
		}
	} else {
		res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

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
