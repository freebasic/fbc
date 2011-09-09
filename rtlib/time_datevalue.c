/* datevalue function */

#include "fb.h"

/*:::::*/
FBCALL int fb_DateValue ( FBSTRING *s )
{
    int year;
    int month;
    int day;
    int succeeded = fb_DateParse( s, &day, &month, &year );

    fb_hStrDelTemp( s );

    if( !succeeded ) {
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        return 0;
    }

    fb_ErrorSetNum( FB_RTERROR_OK );

	return fb_DateSerial( year, month, day );
}

