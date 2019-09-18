/* set end of file */

#include "fb.h"
#include <unistd.h>

int fb_DevFileSetEof( FB_FILE *handle )
{
ssize_t len;
FILE *fp;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp == NULL ) {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    len = ftello( fp );
    if (ftruncate( fileno(fp), len ))
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    FB_UNLOCK();
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
