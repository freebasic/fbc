/* LPTx device */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_DevLptWrite( struct _FB_FILE *handle, const void* value, size_t valuelen )
{
    int res;

    FB_LOCK();

    res = fb_PrinterWrite((DEV_LPT_INFO*) handle->opaque, value, valuelen );

    FB_UNLOCK();

	return res;
}

