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
	if( bytesread )
		*bytesread = 0;

	if( !FB_HANDLE_USED(handle) || !dst || dst_chars < 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* may have to detect the length if given a dereferenced wstring ptr */
	if( dst_chars == 0 ) {
		dst_chars = fb_wstr_Len( dst ) + 1;
	}

	/* need room for at least 1 wchar and the null terminator */
	/* (Get# on a wstring * 1, i.e. just room for the null terminator, is not supported,
	   same as for [z]strings) */
	if( dst_chars < 2 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	/* Fill wchar buffer with raw bytes from the file. */
	/* We request to read in multiples of sizeof(wchar), but EOF can be
	   reached at an odd number of bytes - fb_DevFileRead() will fill the
	   remainder with zeroes at least. */
	size_t rawbytesread;
	int res = fb_FileGetDataEx( handle, pos, (void *)dst, (dst_chars - 1) * sizeof(FB_WCHAR), &rawbytesread, TRUE, FALSE );
	if( res != FB_RTERROR_OK )
		return res;

	if (bytesread)
		*bytesread = rawbytesread;

	/* Add null-terminator */
	int extra = rawbytesread % sizeof(FB_WCHAR);
	if (extra > 0) {
		rawbytesread += sizeof(FB_WCHAR) - extra; /* round up */
	}
	DBG_ASSERT( (rawbytesread % sizeof(FB_WCHAR)) == 0 );
	dst[rawbytesread / sizeof(FB_WCHAR)] = _LC('\0');

	return FB_RTERROR_OK;
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
