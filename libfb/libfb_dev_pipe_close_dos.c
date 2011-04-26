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
int fb_DevPipeClose( struct _FB_FILE *handle )
{
    FILE *fp;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp != NULL ) {
        pclose( fp );
    }

	handle->opaque = NULL;

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

