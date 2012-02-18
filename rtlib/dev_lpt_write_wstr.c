/* LPTx device */

#include "fb.h"

int fb_DevLptWriteWstr( FB_FILE *handle, const FB_WCHAR* value, size_t valuelen )
{
    int res;

    FB_LOCK();

    res = fb_PrinterWriteWstr((DEV_LPT_INFO*) handle->opaque, value, valuelen );

    FB_UNLOCK();

	return res;
}
