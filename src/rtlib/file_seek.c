/* SEEK() and SEEK */

#include "fb.h"

int fb_FileSeekEx( FB_FILE *handle, fb_off_t newpos )
{
	int res;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	FB_LOCK();

    /* clear put back buffer for every modifying non-read operation */
    handle->putback_size = 0;

    /* convert to 0 based file i/o */
    --newpos;
    if( handle->mode == FB_FILE_MODE_RANDOM )
        newpos = newpos * handle->len;

    if (handle->hooks->pfnSeek!=NULL) {
        res = handle->hooks->pfnSeek(handle, newpos, SEEK_SET );
    } else {
        res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	FB_UNLOCK();

	return res;
}

FBCALL int fb_FileSeek( int fnum, int newpos )
{
    return fb_FileSeekEx( FB_FILE_TO_HANDLE(fnum), newpos );
}

FBCALL int fb_FileSeekLarge( int fnum, long long newpos )
{
    return fb_FileSeekEx( FB_FILE_TO_HANDLE(fnum), newpos );
}
