/* input$ function */

#include "fb.h"

FBCALL FBSTRING *fb_FileStrInput( ssize_t bytes, int fnum )
{
    FB_FILE   *handle;
	FBSTRING  *dst;
    size_t 	   len;
    int        res = FB_RTERROR_OK;

	fb_DevScrnInit_Read( );

	FB_LOCK();

    handle = FB_FILE_TO_HANDLE(fnum);
    if( !FB_HANDLE_USED(handle) )
    {
		FB_UNLOCK();
		return &__fb_ctx.null_desc;
	}

    dst = fb_hStrAllocTemp( NULL, bytes );
    if( dst!=NULL )
    {
        ssize_t read_count = 0;
        if( FB_HANDLE_IS_SCREEN(handle) )
        {
            dst->data[0] = 0;
            while( read_count != bytes ) {
                res = fb_FileGetDataEx( handle,
                                        0,
                                        dst->data + read_count,
                                        bytes - read_count,
										&len,
                                        TRUE,
                                        FALSE );
                if( res!=FB_RTERROR_OK ) {
                    break;
                }
                read_count += len;

                /* add the null-term */
                dst->data[read_count] = '\0';
            }
        }
        else
        {
            res = fb_FileGetDataEx( handle,
                                    0,
                                    dst->data,
									bytes,
                                    &len,
                                    TRUE,
                                    FALSE );
            if( res==FB_RTERROR_OK ) {
                read_count += len;
            }
        }

        /* add the null-term */
        dst->data[read_count] = '\0';

        if( read_count != bytes )
        {
            fb_hStrSetLength( dst, read_count );
        }
    }
    else
    {
        res = FB_RTERROR_OUTOFMEM;
    }

    if( res != FB_RTERROR_OK )
    {
        if( dst != NULL )
            fb_hStrDelTemp( dst );

        dst = &__fb_ctx.null_desc;
    }

    FB_UNLOCK();

    return dst;
}

