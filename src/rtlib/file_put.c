/* put # function */

#include "fb.h"

int fb_FilePutDataEx
	(
		FB_FILE *handle,
		fb_off_t pos,
		const void *data,
		size_t length,
		int adjust_rec_pos,
		int checknewline,
		int is_unicode
	)
{
	int res;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	if( pos < 0 )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    res = fb_ErrorSetNum( FB_RTERROR_OK );

    /* clear put back buffer for every modifying non-read operation */
    handle->putback_size = 0;

    /* seek to newpos */
    if( pos > 0 )
        res = fb_FileSeekEx( handle, pos );

    if (res==FB_RTERROR_OK)
    {
        /* do write */
        if( !is_unicode )
        {
        	if( handle->hooks->pfnWrite != NULL )
            	res = handle->hooks->pfnWrite( handle, data, length );
        	else
            	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
        else
        {
        	if( handle->hooks->pfnWriteWstr != NULL )
            	res = handle->hooks->pfnWriteWstr( handle, (FB_WCHAR *)data, length );
        	else
            	res = fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }

    }

    if( handle->mode == FB_FILE_MODE_RANDOM &&
    	res==FB_RTERROR_OK &&
    	adjust_rec_pos &&
        handle->len!=0 &&
        handle->hooks->pfnSeek!=NULL )
    {
        /* if in random mode, writes must be of reclen.
         * The device must also support the SEEK method and the length
         * must be non-null */

		if( length != (size_t)handle->len )
			res = fb_ErrorSetNum( FB_RTERROR_FILEIO );

        size_t skip_size = (handle->len -
        				   ((!is_unicode? length: length*sizeof( FB_WCHAR )) % handle->len)) % handle->len;
        if (skip_size != 0)
        {
            /* devices that don't support seek should simulate it
             with write or never allow to be opened for random access */
            handle->hooks->pfnSeek( handle, skip_size, SEEK_CUR );
        }
    }

#ifndef FB_NATIVE_TAB
    if( checknewline )
    	if ( res == FB_RTERROR_OK )
    	{
    		size_t i = length;
    		if( !is_unicode )
    		{
    			const char *pachText = (const char *) data;

        		/* search for last printed CR or LF */
        		while (i--)
        		{
            		char ch = pachText[i];
            		if (ch=='\n' || ch=='\r')
	                	break;
        		}
        	}
        	else
        	{
    			const FB_WCHAR *pachText = (const FB_WCHAR *) data;

        		/* search for last printed CR or LF */
        		while (i--)
        		{
            		FB_WCHAR ch = pachText[i];
            		if (ch == _LC('\n') || ch== _LC('\r') )
	                	break;
        		}

        	}

	       	handle = FB_HANDLE_DEREF(handle);
        	++i;
        	if (i==0)
	            handle->line_length += length;
    	    else
        	    handle->line_length = length - i;

        	{
            	int iWidth = FB_HANDLE_DEREF(handle)->width;
            	if( iWidth!=0 ) {
                	handle->line_length %= iWidth;
            	}
        	}
    	}
#endif

	FB_UNLOCK();

	/* set the error code again - handle->hooks->pfnSeek() may have reset it */
	return fb_ErrorSetNum( res );
}

int fb_FilePutData
	(
		int fnum,
		fb_off_t pos,
		const void *data,
		size_t length,
		int adjust_rec_pos,
		int checknewline
	)
{
    return fb_FilePutDataEx( FB_FILE_TO_HANDLE(fnum),
    						 pos, data, length, adjust_rec_pos, checknewline, FALSE );
}

FBCALL int fb_FilePut
	(
		int fnum,
		int pos,
		void* value,
		size_t valuelen
	)
{
	return fb_FilePutData( fnum, pos, value, valuelen, TRUE, FALSE );
}

FBCALL int fb_FilePutLarge
	(
		int fnum,
		long long pos,
		void *value,
		size_t valuelen
	)
{
	return fb_FilePutData( fnum, pos, value, valuelen, TRUE, FALSE );
}
