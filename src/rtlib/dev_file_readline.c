/* file device */

#include "fb.h"

static char *hWrapper( char *buffer, size_t count, FILE *fp )
{
    return fgets( buffer, count, fp );
}

int fb_DevFileReadLineDumb
	( 
		FILE *fp, 
		FBSTRING *dst, 
		fb_FnDevReadString pfnReadString 
	)
{
    int res = fb_ErrorSetNum( FB_RTERROR_OK );
    size_t buffer_len;
    int found, first_run;
    char buffer[512];
    FBSTRING src = { &buffer[0], 0, 0 };

    DBG_ASSERT( dst!=NULL );

    buffer_len = sizeof(buffer);
    first_run = TRUE;

	FB_LOCK();

	if( pfnReadString == NULL )
		pfnReadString = hWrapper;
    
    found = FALSE;
    while (!found)
    {
        memset( buffer, 0, buffer_len );

        if( pfnReadString( buffer, sizeof( buffer ), fp ) == NULL )
        {
            /* EOF reached ... this is not an error !!! */
            res = FB_RTERROR_ENDOFFILE; /* but we have to notify the caller */

            if( first_run )
            	fb_StrDelete( dst );

            break;
        }

        /* the last character always is NUL */
        buffer_len = sizeof(buffer) - 1;

        /* now let's find the end of the buffer */
        while (buffer_len--)
        {
            char ch = buffer[buffer_len];
            if (ch==13 || ch==10)
            {
                /* accept both CR and LF */
                found = TRUE;
                break;
            }
            else if( ch!=0 )
            {
                /* a character other than CR/LF found ... i.e. buffer full */
                break;
            }
        }

        ssize_t tmp_buf_len;
        
        if( !found )
        {
            /* remember the real length */
            tmp_buf_len = buffer_len += 1;

            /* not found ... so simply add this to the result string */
        }
        else
        {
            /* remember the real length */
            tmp_buf_len = buffer_len + 1;

            /* filter a (possibly valid) CR/LF sequence */
            if( buffer[buffer_len]==10 && buffer_len!=0 )
            {
                if( buffer[buffer_len-1]==13 )
                {
                    --buffer_len;
                }
            }

            /* set the CR or LF to NUL */
            buffer[buffer_len] = 0;
        }

        src.size = src.len = buffer_len;

        /* assign or concatenate */
        if( first_run )
        	fb_StrAssign( dst, -1, &src, -1, FALSE );
        else
        	fb_StrConcatAssign( dst, -1, &src, -1, FALSE );

        first_run = FALSE;

        buffer_len = tmp_buf_len;
    }

	FB_UNLOCK();

	return res;

}

int fb_DevFileReadLine( FB_FILE *handle, FBSTRING *dst )
{
    int res;
    FILE *fp;

	FB_LOCK();

    fp = (FILE*) handle->opaque;
    if( fp==stdout || fp==stderr )
        fp = stdin;

    if( fp == NULL )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

    res = fb_DevFileReadLineDumb( fp, dst, NULL );

	FB_UNLOCK();

	return res;
}
