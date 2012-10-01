/* Sets a file handles line length */

#include "fb.h"

FBCALL int fb_SetPos( FB_FILE *handle, int line_length )
{
    FB_LOCK();
    handle->line_length = line_length;
	FB_UNLOCK();

    return fb_ErrorSetNum( FB_RTERROR_OK );
}
