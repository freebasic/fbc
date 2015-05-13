/* UTF-encoded file writing */

#include "fb.h"

int fb_DevFileWriteEncod( FB_FILE *handle, const void* buffer, size_t chars )
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

	/* convert (note: encoded file can only be opened in text-mode, so no
	   			PUT# is allowed, no binary data should be emitted ever) */
	encod_buffer = fb_CharToUTF( handle->encod,
								 (const char *)buffer,
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

		if( encod_buffer != buffer )
			free( encod_buffer );
	}

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
