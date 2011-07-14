/* file device */

#include "fb.h"

int fb_DevPipeClose( struct _FB_FILE *handle )
{
    return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
}

