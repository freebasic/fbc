/*
 * io_setpos.c -- Sets a file handles line length
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include <stdio.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_SetPos( FB_FILE *handle, int line_length )
{
    FB_LOCK();

    handle->line_length = line_length;

	FB_UNLOCK();
	
    return fb_ErrorSetNum( FB_RTERROR_OK );
}
