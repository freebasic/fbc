/* LPTx device */

#include "fb.h"

int fb_DevLptWrite( FB_FILE *handle, const void* value, size_t valuelen )
{
    int res;

    FB_LOCK();

    res = fb_PrinterWrite((DEV_LPT_INFO*) handle->opaque, value, valuelen );

    FB_UNLOCK();

	return res;
}
