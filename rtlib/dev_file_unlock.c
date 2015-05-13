/* file device */

#include "fb.h"

int fb_DevFileUnlock( FB_FILE *handle, fb_off_t position, fb_off_t size )
{
	int 	res;
	FILE 	*fp;

	if( size==0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

	fp = (FILE*) handle->opaque;
	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	res = fb_hFileUnlock( fp, position, size );

	FB_UNLOCK();

	return res;
}
