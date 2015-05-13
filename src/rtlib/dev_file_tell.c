/* file device */

#include "fb.h"

int fb_DevFileTell( FB_FILE *handle, fb_off_t *pOffset )
{
	FILE *fp;

	FB_LOCK();

	fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	*pOffset = ftello( fp );

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
