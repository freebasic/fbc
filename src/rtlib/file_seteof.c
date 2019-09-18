/* truncate file */

#include "fb.h"

FBCALL int fb_SetEof( int fnum )
{
/***********************************************************************************************
 Truncate a file opened for BINARY or RANDOM at the current position. Everything before the 
 current position is kept, everything afterwards including the current position is discarded. 
 You might set the current position with SEEK ... before. Setting the current position to 6 
 results in a file of 5 (!) bytes lenght. For BINARY files the current position is the byte 
 position, for RANDOM files seek sets the current position in records.
***********************************************************************************************/
FB_FILE *handle;

    FB_LOCK();
    handle = FB_FILE_TO_HANDLE(fnum);

    if (!handle)
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if (handle->type != FB_FILE_TYPE_VFS)
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if ((handle->mode != FB_FILE_MODE_BINARY) && (handle->mode != FB_FILE_MODE_RANDOM))
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( handle->hooks && handle->hooks->pfnSetEof )
    {
        FB_UNLOCK();
        return handle->hooks->pfnSetEof( handle );
    }
    else
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }  
}
