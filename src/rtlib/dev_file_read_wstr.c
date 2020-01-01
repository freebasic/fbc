/* file device */

#include "fb.h"

int fb_DevFileReadWstr( FB_FILE *handle, FB_WCHAR *dst, size_t *pchars )
{
    FILE *fp;
    size_t chars;
    char *buffer;

    FB_LOCK();

    if( handle == NULL )
        fp = stdin;
    else
    {
        fp = (FILE*) handle->opaque;
        if( fp == stdout || fp == stderr )
            fp = stdin;

        if( fp == NULL )
        {
            FB_UNLOCK();
            return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        }
    }

    chars = *pchars;

	if( chars < FB_LOCALBUFF_MAXLEN )
	{
		buffer = alloca( chars + 1 );
		/* note: if out of memory on alloca, it's a stack exception */
	}
	else
	{
		buffer = malloc( chars + 1 );
		if( buffer == NULL )
		{
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_OUTOFMEM );
		}
	}

	/* do read */
	chars = fread( buffer, 1, chars, fp );
	buffer[chars] = '\0';

	/* convert to wchar, file should be opened with the ENCODING option
	   to allow UTF characters to be read */
	fb_wstr_ConvFromA( dst, chars, buffer );

	if( *pchars >= FB_LOCALBUFF_MAXLEN )
		free( buffer );

	/* fill with nulls if at eof */
	if( chars != *pchars )
        memset( (void *)&dst[chars], 0, (*pchars - chars) * sizeof( FB_WCHAR ) );

    *pchars = chars;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
