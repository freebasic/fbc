/* file device */

#include "fb.h"

/*:::::*/
int fb_DevScrnClose( struct _FB_FILE *handle )
{
    FB_LOCK();

    if( handle->opaque != NULL )
        free(handle->opaque);

    FB_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
