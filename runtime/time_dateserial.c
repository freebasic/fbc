/* dateserial function */

#include "fb.h"

/*:::::*/
FBCALL int fb_DateSerial ( int year, int month, int day )
{
    int result = 2;
    int cur_year = 1900;
    int cur_month = 1;
    int cur_day = 1;

    fb_hNormalizeDate( &day, &month, &year );

    if( cur_year < year ) {
        while( cur_year != year ) {
            result += fb_hTimeDaysInYear( cur_year++ );
        }
    } else {
        while( cur_year != year ) {
            result -= fb_hTimeDaysInYear( --cur_year );
        }
    }

    while( cur_month != month ) {
        result += fb_hTimeDaysInMonth( cur_month++, year );
    }

    result += day - cur_day;

	return result;
}

