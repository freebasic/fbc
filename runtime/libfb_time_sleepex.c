/* sleep multiplexer function */

#include "fb.h"

/*:::::*/
FBCALL int fb_SleepEx ( int msecs, int kind )
{
    switch( kind ) {
    case 0:
        fb_Sleep( msecs );
        break;
    case 1:
        fb_Delay( msecs );
        break;
    default:
        return fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
    }
    return fb_ErrorSetNum( FB_RTERROR_OK );
}

