/* eof function */

#include "fb.h"

/*:::::*/
int fb_FileEofEx( FB_FILE *handle )
{
    int res;

    if( !FB_HANDLE_USED(handle) )
        return FB_TRUE;

    FB_LOCK();

    if( handle->hooks == NULL || handle->hooks->pfnEof==NULL ) {
		FB_UNLOCK();
		return FB_TRUE;
    }

    if( handle->putback_size != 0 ) {
        FB_UNLOCK();
        return FB_FALSE;
    }

    if( handle->hooks->pfnEof != NULL ) {
        res = handle->hooks->pfnEof( handle );
    } else {
        res = FB_TRUE;
    }

	FB_UNLOCK();

	return res;
}

/*:::::*/
FBCALL int fb_FileEof( int fnum )
{
    return fb_FileEofEx(FB_FILE_TO_HANDLE(fnum));
}

