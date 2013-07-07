/* some kind of ungetc function */

#include "fb.h"

int fb_FilePutBackEx( FB_FILE *handle, const void *src, size_t chars )
{
	int res;
	size_t bytes;

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
        /* note: if encoding != ASCII, putback buffer will be in
           wchar format, not in UTF */
        if( handle->putback_size )
        {
            memmove( handle->putback_buffer + bytes,
                     handle->putback_buffer,
                     handle->putback_size );
        }

        if( handle->encod == FB_FILE_ENCOD_ASCII )
        	memcpy( handle->putback_buffer, src, bytes );
        else
        {
    		/* char to wchar */
    		FB_WCHAR *dst = (FB_WCHAR *)handle->putback_buffer;
    		const char *patch = (const char *)src;
        	while( chars-- > 0 )
        		*dst++ = *patch++;
        }

        handle->putback_size += bytes;
    }

	FB_UNLOCK();

	return res;
}

FBCALL int fb_FilePutBack( int fnum, const void *data, size_t length )
{
    return fb_FilePutBackEx( FB_FILE_TO_HANDLE(fnum), data, length );
}
