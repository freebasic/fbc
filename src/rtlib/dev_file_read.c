/* file device */

#include "fb.h"

int fb_DevFileRead( FB_FILE *handle, void *dst, size_t *pLength )
{
    FILE *fp;
    size_t rlen, length;

    FB_LOCK();

    DBG_ASSERT(pLength!=NULL);
    length = *pLength;

    if( handle == NULL )
        fp = stdin;
    else
    {
        fp = (FILE *)handle->opaque;
        if( fp == stdout || fp == stderr )
            fp = stdin;

        if( fp == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    /* do read */
    rlen = FB_FREAD_LARGE( dst, length, fp );
    /* fill with nulls if at eof */
    if( rlen != length )
        memset( ((char *)dst) + rlen, 0, length - rlen );

    *pLength = rlen;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
