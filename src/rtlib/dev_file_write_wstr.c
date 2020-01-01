/* wstring to ascii file writing function */

#include "fb.h"

int fb_DevFileWriteWstr( FB_FILE *handle, const FB_WCHAR* src, size_t chars )
{
    FILE *fp;
    char *buffer;
    int res;

    FB_LOCK();

    fp = (FILE*) handle->opaque;

	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

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

	/* convert to ascii, file should be opened with the ENCODING option
	   to allow UTF characters to be written */
	fb_wstr_ConvToA( buffer, chars, src );

	/* do write */
	res = fwrite( (void *)buffer, 1, chars, fp ) == chars;

	if( chars >= FB_LOCALBUFF_MAXLEN )
		free( buffer );

	FB_UNLOCK();

	return fb_ErrorSetNum( (res? FB_RTERROR_OK: FB_RTERROR_FILEIO) );
}
