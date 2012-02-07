/* set the with for files */

#include "fb.h"

/*:::::*/
FBCALL int fb_WidthFile( int fnum, int width )
{
    int cur = width;
    FB_FILE *handle;

    FB_LOCK();

    handle = FB_HANDLE_DEREF(FB_FILE_TO_HANDLE(fnum));

    if( !FB_HANDLE_USED(handle) ) {
        /* invalid file handle */
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( handle->hooks==NULL ) {
        /* not opened yet */
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    if( handle==FB_HANDLE_SCREEN ) {
        /* SCREEN device */
        if( width!=-1 ) {
            fb_Width( width, -1 );
        }
        cur = FB_HANDLE_SCREEN->width;

    } else {
        if( width!=-1 ) {
            handle->width = width;
            if( handle->hooks->pfnSetWidth!=NULL )
                handle->hooks->pfnSetWidth( handle, width );
        }
        cur = handle->width;
    }

	FB_UNLOCK();

    if( width==-1 ) {
        return cur;
    }

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
