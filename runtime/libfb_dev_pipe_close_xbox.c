/*
 *	dev_file - file device
 *
 * chng: jul/2005 written [mjs]
 *
 */

#include "fb.h"

int fb_DevPipeClose( struct _FB_FILE *handle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

