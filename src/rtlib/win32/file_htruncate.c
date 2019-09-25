/* truncate file / set end of file */

#include "../fb.h"
#include <unistd.h>

int fb_hFileTruncateEx( FB_FILE *handle )
{
    fb_off_t pos;

    FILE *fp;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

    if( fp == NULL ) {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    pos = ftello( fp );
    if( ftruncate( fileno(fp), pos ) )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_FILEIO );
    }

    FB_UNLOCK();
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
