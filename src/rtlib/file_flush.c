/* flush file buffers to disk (or writable device)*/

#include "fb.h"

int fb_FileFlushEx( FB_FILE *handle )
{
    int res;

    FB_LOCK();

    if( !FB_HANDLE_USED(handle) )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if (handle->access == FB_FILE_ACCESS_READ)
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( handle->hooks && handle->hooks->pfnFlush )
    {
        res = handle->hooks->pfnFlush( handle );
    }
    else
    {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    FB_UNLOCK();

    return res;
}

/*:::::*/
FBCALL int fb_FileFlush( int fnum )
{
    return fb_FileFlushEx(FB_FILE_TO_HANDLE(fnum));
}

