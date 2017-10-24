/* UTF-encoded input for file devices */

#include "fb.h"

int fb_DevFileReadEncodWstr( FB_FILE *handle, FB_WCHAR *dst, size_t *max_chars )
{
    FILE *fp;
    size_t chars;

    FB_LOCK();

    chars = *max_chars;

    fp = (FILE *)handle->opaque;
    if( fp == stdout || fp == stderr )
        fp = stdin;

    if( fp == NULL )
    {
        FB_UNLOCK();
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }

	/* do read */
	chars = fb_hFileRead_UTFToWchar( fp, handle->encod, dst, chars );

	/* fill with nulls if at eof */
	if( chars != *max_chars )
        memset( (char *)&dst[chars], 0, (*max_chars - chars) * sizeof( FB_WCHAR ) );

    *max_chars = chars;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
