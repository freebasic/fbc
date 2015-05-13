/* file device */

#include "fb.h"

int fb_DevPipeClose( FB_FILE *handle )
{
#if defined( HOST_DOS ) || defined( HOST_UNIX ) || defined( HOST_WIN32 )
	FILE *fp;

	FB_LOCK();

	fp = (FILE*) handle->opaque;
	if( fp != NULL ) {
#ifdef HOST_MINGW
		_pclose( fp );
#else
		pclose( fp );
#endif
	}

	handle->opaque = NULL;

	FB_UNLOCK();
	return fb_ErrorSetNum( FB_RTERROR_OK );
#else
	return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
#endif
}
