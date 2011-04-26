/*
 *	file_get - get # function for arrays
 *
 * chng: jan/2005 written [v1ctor]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"


/*:::::*/
FBCALL int fb_FileGetArray( int fnum, long pos, FBARRAY *dst )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, NULL, TRUE, FALSE );
}

/*:::::*/
FBCALL int fb_FileGetArrayLarge( int fnum, long long pos, FBARRAY *dst )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, NULL, TRUE, FALSE );
}

/*:::::*/
FBCALL int fb_FileGetArrayIOB( int fnum, long pos, FBARRAY *dst, unsigned int *bytesread )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, bytesread, TRUE, FALSE );
}

/*:::::*/
FBCALL int fb_FileGetArrayLargeIOB( int fnum, long long pos, FBARRAY *dst, unsigned int *bytesread )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum), pos, dst->ptr, dst->size, bytesread, TRUE, FALSE );
}
