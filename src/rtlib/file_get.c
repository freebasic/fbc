/* get # function */

#include "fb.h"

int fb_FileGetDataEx
	(
		FB_FILE *handle,
		fb_off_t pos,
		void *dst,
		size_t length,
		size_t *bytesread,
		int adjust_rec_pos,
		int is_unicode
	)
{
    int res;
    size_t chars, read_chars;
    char *pachData = (char *)dst;

	if( bytesread )
		*bytesread = 0;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( pos < 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    chars = length;

    /* seek to newpos */
    if( pos > 0 )
        res = fb_FileSeekEx( handle, pos );

    /* any data in the put-back buffer? */
    if( handle->putback_size != 0 )
    {
        size_t bytes, len;
    	FB_WCHAR *wcp;
    	char *cp;

        bytes = chars;
        if( handle->encod != FB_FILE_ENCOD_ASCII )
        	bytes *= sizeof( FB_WCHAR );

        bytes = (handle->putback_size >= bytes? bytes : handle->putback_size);

        if( !is_unicode )
        {
        	if( handle->encod == FB_FILE_ENCOD_ASCII )
        		memcpy( pachData, handle->putback_buffer, bytes );
        	else
        	{
        		cp = pachData;
        		wcp = (FB_WCHAR *)handle->putback_buffer;
        		len = bytes;
        		while( len > 0 )
        		{
        			*cp++ = *wcp++;
        			len -= sizeof( FB_WCHAR );
        		}
        	}
        }
        else
        {
        	if( handle->encod != FB_FILE_ENCOD_ASCII )
        		memcpy( pachData, handle->putback_buffer, bytes );
        	else
        	{
        		cp = pachData;
        		wcp = (FB_WCHAR *)handle->putback_buffer;
        		len = bytes;
        		while( len-- > 0 )
        			*wcp++ = *cp++;
        	}
        }

        handle->putback_size -= bytes;
        if( handle->putback_size != 0 )
        {
            memmove( handle->putback_buffer,
                     handle->putback_buffer + bytes,
                     handle->putback_size );
		}

        pachData += bytes;

        if( handle->encod != FB_FILE_ENCOD_ASCII )
        	bytes /= sizeof( FB_WCHAR );

        read_chars = bytes;
        chars -= bytes;
    }
    else
    	read_chars = 0;

    if ( (res == FB_RTERROR_OK) && (chars != 0) )
    {
        /* do read */
        if( !is_unicode )
        {
        	if( handle->hooks->pfnRead == NULL )
            	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        	else
        	{
        		res = handle->hooks->pfnRead( handle, pachData, &chars );
        		read_chars += chars;
        	}
        }
        else
        {
        	if( handle->hooks->pfnReadWstr == NULL )
            	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        	else
        	{
        		res = handle->hooks->pfnReadWstr( handle, (FB_WCHAR *)pachData, &chars );
        		read_chars += chars;
        	}
        }
    }

    if( handle->mode == FB_FILE_MODE_RANDOM &&
        res == FB_RTERROR_OK &&
        adjust_rec_pos &&
        handle->len != 0 &&
        handle->hooks->pfnSeek != NULL )
    {
        /* if in random mode, reads must be of reclen.
         * The device must also support the SEEK method and the length
         * must be non-null */

		if( length != (size_t)handle->len )
			res = fb_ErrorSetNum( FB_RTERROR_FILEIO );


		size_t skip_size = (handle->len -
        				   ((!is_unicode? read_chars: read_chars*sizeof( FB_WCHAR )) % handle->len)) % handle->len;

        if( skip_size != 0 )
        {
            /* don't forget the put back buffer */
            if( skip_size > handle->putback_size )
            {
                skip_size -= handle->putback_size;
                handle->putback_size = 0;
            }
            else
            {
                handle->putback_size -= skip_size;
                skip_size = 0;
            }
        }

        if (skip_size!=0)
        {
            /* devices that don't support seek should simulate it
             with read or never allow to be opened for random access */
            handle->hooks->pfnSeek( handle, skip_size, SEEK_CUR );
        }
    }

	if( bytesread )
		*bytesread = read_chars;

	FB_UNLOCK();

	/* set the error code again - handle->hooks->pfnSeek() may have reset it */
	return fb_ErrorSetNum( res );
}

/*:::::*/
/* Can fb_FileGetData() be removed? it's not used by the rtlib
 * nor is it referenced by fbc?  Compatibility with old libs? [jeffm]
 */
int fb_FileGetData( int fnum, fb_off_t pos, void *dst, size_t chars, int adjust_rec_pos )
{
    return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum),
    						 pos,
    						 dst,
    						 chars,
							 NULL,
    						 adjust_rec_pos,
    						 FALSE );
}

FBCALL int fb_FileGet( int fnum, int pos, void *dst, size_t chars )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum),
							 pos,
							 dst,
							 chars,
							 NULL,
							 TRUE,
							 FALSE );
}

FBCALL int fb_FileGetLarge( int fnum, long long pos, void *dst, size_t chars )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum),
							 pos,
							 dst,
							 chars,
							 NULL,
							 TRUE,
							 FALSE );
}

FBCALL int fb_FileGetIOB( int fnum, int pos, void *dst, size_t chars, size_t *bytesread )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum),
							 pos,
							 dst,
							 chars,
							 bytesread,
							 TRUE,
							 FALSE );
}

FBCALL int fb_FileGetLargeIOB( int fnum, long long pos, void *dst, size_t chars, size_t *bytesread )
{
	return fb_FileGetDataEx( FB_FILE_TO_HANDLE(fnum),
							 pos,
							 dst,
							 chars,
							 bytesread,
							 TRUE,
							 FALSE );
}
