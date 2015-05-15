/* line input function */

#include "fb.h"

#define BUFFER_LEN 1024

typedef enum _eInputMode {
    eIM_Invalid,
    eIM_ReadLine,
    eIM_Read
} eInputMode;

static int fb_hFileLineInputEx
	(
		FB_FILE *handle,
		void *dst,
		ssize_t dst_len,
		int fillrem
	)
{
	ssize_t len, readlen;
	char		buffer[BUFFER_LEN];
    eInputMode  mode = eIM_Invalid;

    if( !FB_HANDLE_USED(handle) )
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

    FB_LOCK();

    if( handle->hooks->pfnReadLine != NULL ) {
        mode = eIM_ReadLine;
    } else if( handle->hooks->pfnRead != NULL &&
               handle->hooks->pfnEof != NULL )
    {
        mode = eIM_Read;
    }

    switch( mode ) {
    case eIM_Read:
        /* This is the VFS-compatible way to read a line ... but it's slow */
        len = readlen = 0;
        while (!handle->hooks->pfnEof(handle)) {
            int do_add = FALSE, do_break = FALSE;
            size_t read_len;
            int res = fb_FileGetDataEx( handle, 0, buffer+len, 1, &read_len, FALSE, FALSE );
            if( res==FB_RTERROR_OK && read_len==1) {
                char ch = buffer[len];
                if( ch==13 ) {
                    res = fb_FileGetDataEx( handle, 0, &ch, 1, &read_len, FALSE, FALSE );
                    if( res==FB_RTERROR_OK && ch!=10 && read_len==1) {
                        fb_FilePutBackEx( handle, &ch, 1 );
                    }
                    ch = 10;
                }
                if( ch==10 ) {
                    do_add = do_break = TRUE;
                } else {
                    do_add = len==(sizeof(buffer)-1);
                }
            } else {
                do_add = len!=0;
            }
            if( do_add || handle->hooks->pfnEof( handle ) ) {
                /* create temporary string to ensure that NUL's are preserved ...
                 * this function wants the length WITH the NUL character!!! */
                buffer[len] = 0;
                FBSTRING *src = fb_StrAllocTempDescF( buffer, len + 1);
                if( readlen==0 ) {
                    fb_StrAssign( dst, dst_len, src, -1, fillrem );
                } else {
                    fb_StrConcatAssign ( dst, dst_len, src, -1, fillrem );
                }
                readlen += len;
                len = 0;
            } else {
                ++len;
            }
            if( res!=FB_RTERROR_OK || do_break )
                break;
        }
        if( readlen == 0 ) {
            /* del destine string */
            if( dst_len == -1 )
                fb_StrDelete( (FBSTRING *)dst );
            else
                *(char *)dst = '\0';
        }
        break;
    case eIM_ReadLine:
        /* The read line mode is the most comfortable ... but IMHO it's
         * only useful for special devices (like SCRN:) */
        {
            /* destine is a var-len string? read directly */
            if( dst_len == -1 )
            {
            	handle->hooks->pfnReadLine( handle, dst );
            }
            /* fixed-len or unknown size (ie: pointers)? use a temp var-len */
            else
            {
			FBSTRING str_result = { 0, 0, 0 };

            	/* read complete line (may include NULs) */
            	handle->hooks->pfnReadLine( handle, &str_result );

            	/* add contents of tempporary string to result buffer */
            	fb_StrAssign( dst, dst_len, (void *)&str_result, -1, fillrem );

            	/* delete result */
            	fb_StrDelete( &str_result );
            }

        }
        break;
    case eIM_Invalid:
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}

FBCALL int fb_FileLineInput( int fnum, void *dst, ssize_t dst_len, int fillrem )
{
    return fb_hFileLineInputEx( FB_FILE_TO_HANDLE(fnum), dst, dst_len, fillrem );
}
