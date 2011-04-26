/*
 *	dev_lpt - LPTx device
 *
 * chng: jul/2006 written [jeffmarshall]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_DevLptWriteWstr( struct _FB_FILE *handle, const FB_WCHAR* value, size_t valuelen )
{
    int res;

    FB_LOCK();

    res = fb_PrinterWriteWstr((DEV_LPT_INFO*) handle->opaque, value, valuelen );

    FB_UNLOCK();

	return res;
}

