/* file device */

#include "fb.h"

int fb_DevScrnClose( FB_FILE *handle )
{
    FB_LOCK();
	fb_DevScrnEnd( handle );
    FB_UNLOCK();
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
