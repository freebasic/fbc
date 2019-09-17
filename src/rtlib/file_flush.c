/* flush file */

#include "fb.h"

FBCALL int fb_FileFlush( int fnum )
/* flush file buffers to disk */
{
FB_FILE *handle;

    int res;

    FB_LOCK();
    handle = FB_FILE_TO_HANDLE(fnum);

    if (!handle)
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
