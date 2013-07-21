/* ungetwc-like function */

#include "fb.h"

int fb_FilePutBackWstrEx( FB_FILE *handle, const FB_WCHAR *src, size_t chars )
{
	int res;
	size_t bytes;
    char *dst;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    /* UTF? */
    if( handle->encod != FB_FILE_ENCOD_ASCII )
    	bytes = chars * sizeof( FB_WCHAR );
    else
    	bytes = chars;

    if( handle->putback_size + bytes > sizeof(handle->putback_buffer) )
    {
        res = fb_ErrorSetNum( FB_RTERROR_FILEIO );
    }
    else
    {
        if( handle->putback_size )
            memmove( handle->putback_buffer + bytes,
                     handle->putback_buffer,
                     handle->putback_size );

        handle->putback_size += bytes;

        /* note: if encoding != ASCII, putback buffer will be in
           wchar format, not in UTF */
        if( handle->encod != FB_FILE_ENCOD_ASCII )
        	memcpy( handle->putback_buffer, src, bytes );
        else
        {
        	/* wchar to char */
        	dst = handle->putback_buffer;
        	while( chars-- > 0 )
        		*dst++ = *src++;
        }
    }

	FB_UNLOCK();

	return res;
}

FBCALL int fb_FilePutBackWstr( int fnum, const FB_WCHAR *src, size_t chars )
{
    return fb_FilePutBackWstrEx( FB_FILE_TO_HANDLE(fnum), src, chars );
}
