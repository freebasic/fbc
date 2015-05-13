/* UTF-encoded wstring file writing */

#include "fb.h"

int fb_DevFileWriteEncodWstr( FB_FILE *handle, const FB_WCHAR* buffer, size_t chars )
{
    FILE *fp;
    char *encod_buffer;
	ssize_t bytes;

    FB_LOCK();

    fp = (FILE*) handle->opaque;
	if( fp == NULL ) {
		FB_UNLOCK();
		return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
	}

	/* convert (note: only wstrings will be written using this function,
				so there's no binary data to care) */
	encod_buffer = fb_WCharToUTF( handle->encod,
								  buffer,
								  chars,
								  NULL,
								  &bytes );

	if( encod_buffer != NULL )
	{
		/* do write */
		if( fwrite( encod_buffer, 1, bytes, fp ) != (size_t)bytes )
		{
			FB_UNLOCK();
			return fb_ErrorSetNum( FB_RTERROR_FILEIO );
		}

		if( encod_buffer != (char *)buffer )
			free( encod_buffer );
	}

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
