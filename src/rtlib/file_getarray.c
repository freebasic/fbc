/* get # function for arrays */

#include "fb.h"

FBCALL int fb_FileGetArray( int fnum, int pos, FBARRAY *dst )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, NULL, TRUE, FALSE );
}

FBCALL int fb_FileGetArrayLarge( int fnum, long long pos, FBARRAY *dst )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, NULL, TRUE, FALSE );
}

FBCALL int fb_FileGetArrayIOB( int fnum, int pos, FBARRAY *dst, size_t *bytesread )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, bytesread, TRUE, FALSE );
}

FBCALL int fb_FileGetArrayLargeIOB( int fnum, long long pos, FBARRAY *dst, size_t *bytesread )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, bytesread, TRUE, FALSE );
}
