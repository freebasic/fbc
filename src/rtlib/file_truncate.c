/* truncate file */

#include "fb.h"

/*
    Truncate a file opened for BINARY, RANDOM, OUTPUT, or APPEND

    Current position is used to determine where to truncate the file.
    Everything before the current position is kept, everything 
    afterwards including the current position is discarded.

    You might set the current position with SEEK. . Or current position
    may be determined by previous read/write operations.

    For BINARY, OUTPUT, and APPEND files the current position is the byte.

    For RANDOM files, the current position is the record.
*/

int fb_FileTruncateEx( FB_FILE *handle )
{
    int res;

    FB_LOCK();

    if( !FB_HANDLE_USED(handle) )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    switch( handle->mode )
    {
    case FB_FILE_MODE_BINARY:
    case FB_FILE_MODE_RANDOM:
    case FB_FILE_MODE_OUTPUT:
    case FB_FILE_MODE_APPEND:
        break;
    default:
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        break;
    }

    /* flush stream buffers before truncating */
    res = fb_FileFlushEx( handle, FALSE );

    /* call the platform specifc implementation */
    if( res == FB_RTERROR_OK )
        res = fb_hFileTruncateEx( (FILE*)handle->opaque );

    FB_UNLOCK();

    return res;
}

/*:::::*/
FBCALL int fb_FileTruncate( int fnum )
{
    return fb_FileTruncateEx(FB_FILE_TO_HANDLE(fnum));
}
