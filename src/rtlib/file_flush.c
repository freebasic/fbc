/* flush file */

#include "fb.h"

FBCALL int fb_FileFlush( int fnum )
/* flush file buffers to disk */
{
FB_FILE *handle;

    FB_LOCK();
    handle = FB_FILE_TO_HANDLE(fnum);

    if (!handle)
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if (handle->type != FB_FILE_TYPE_NORMAL)
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
        FB_UNLOCK();
        return handle->hooks->pfnFlush( handle );
    }
    else
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }  
}
