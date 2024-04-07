/* file device */

#include "fb.h"

int fb_DevStdIoClose( FB_FILE *handle )
{
	FB_LOCK();

	handle->opaque = NULL;

	FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
