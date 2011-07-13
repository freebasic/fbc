/*
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fb.h"

/*:::::*/
int fb_DevFileSeek( struct _FB_FILE *handle, fb_off_t offset, int whence )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	res = fb_ErrorSetNum( fseeko( fp, offset, whence ) == 0 ? FB_RTERROR_OK : FB_RTERROR_FILEIO );

	FB_UNLOCK();

	return res;
}
