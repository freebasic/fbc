/* flush file buffers to disk (or writable device)*/

#include "fb.h"

int fb_FileFlushEx( FB_FILE *handle, int systembuffers )
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

    if( handle->hooks && handle->hooks->pfnFlush )
    {
        res = handle->hooks->pfnFlush( handle );
        if( res == FB_RTERROR_OK && systembuffers != 0 )
        {
            res = fb_hFileFlushEx( (FILE *)handle->opaque );
        }
    }
    else
    {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    FB_UNLOCK();

    return res;
}

/*:::::*/
FBCALL void fb_FileFlushAll ( int systembuffers )
{
    int i;

    FB_LOCK();

    for( i = 1; i <= (FB_MAX_FILES - FB_RESERVED_FILES); i++ ) 
    {
        FB_FILE *handle = FB_FILE_TO_HANDLE_VALID( i );
        if( handle->hooks && handle->hooks->pfnFlush )
        {
            int res = handle->hooks->pfnFlush( handle );
            if( res == FB_RTERROR_OK && systembuffers != 0 )
            {
                fb_hFileFlushEx( (FILE *)handle->opaque );
            }
        }
    }

    FB_UNLOCK();
}

/*:::::*/
FBCALL int fb_FileFlush( int fnum, int systembuffers )
{
    if( fnum == -1 )
    {
        fb_FileFlushAll( systembuffers );
        return fb_ErrorSetNum( FB_RTERROR_OK );
    }

    return fb_FileFlushEx(FB_FILE_TO_HANDLE(fnum), systembuffers );
}
