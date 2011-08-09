/* timevalue function */

#include "fb.h"

/*:::::*/
FBCALL double fb_TimeValue ( FBSTRING *s )
{
    int hour;
    int minute;
    int second;
    int succeeded = fb_TimeParse( s, &hour, &minute, &second );

    fb_hStrDelTemp( s );

    if( !succeeded ) {
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        return 0;
    }

    fb_ErrorSetNum( FB_RTERROR_OK );

	return fb_TimeSerial( hour, minute, second );
}

