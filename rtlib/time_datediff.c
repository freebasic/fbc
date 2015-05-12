/* datediff function */

#include "fb.h"
#include <math.h>

/*:::::*/
FBCALL long long fb_DateDiff( FBSTRING *interval, double serial1, double serial2,
                              int first_day_of_week, int first_day_of_year )
{
    int year1, month1, hour, minute, second, week;
    int year2, month2;
    long long result = 0;
    double serial;
    int interval_type = fb_hTimeGetIntervalType( interval );

    fb_ErrorSetNum( FB_RTERROR_OK );

    switch ( interval_type ) {
    case FB_TIME_INTERVAL_YEAR:
        fb_hDateDecodeSerial ( serial1, &year1, NULL, NULL );
        fb_hDateDecodeSerial ( serial2, &year2, NULL, NULL );
        result = year2 - year1;
        break;
    case FB_TIME_INTERVAL_QUARTER:
    case FB_TIME_INTERVAL_MONTH:
        fb_hDateDecodeSerial ( serial1, &year1, &month1, NULL );
        fb_hDateDecodeSerial ( serial2, &year2, &month2, NULL );
        result = (month2 - month1) + (year2 - year1) * 12;
        if( interval_type==FB_TIME_INTERVAL_QUARTER )
            result = result / 3;
        break;
    case FB_TIME_INTERVAL_DAY_OF_YEAR:
    case FB_TIME_INTERVAL_DAY:
        result = (long long) (floor(serial2) - floor(serial1));
        break;
    case FB_TIME_INTERVAL_WEEKDAY:
    case FB_TIME_INTERVAL_WEEK_OF_YEAR:
        fb_hDateDecodeSerial ( serial1, &year1, NULL, NULL );
        week = fb_hGetWeekOfYear( year1,
                                  serial1,
                                  first_day_of_year, first_day_of_week );
        result = fb_hGetWeekOfYear( year1,
                                    serial2,
                                    first_day_of_year, first_day_of_week );
        if( week > 0 )
            --week;
        if( result > 0 )
            --result;
        result -= week;
        if( interval_type==FB_TIME_INTERVAL_WEEKDAY ) {
            int add_value;
            if( serial1 > serial2 ) {
                double serial_tmp = serial1;
                serial1 = serial2;
                serial2 = serial_tmp;
                add_value = 1;
            } else {
                add_value = -1;
            }
            if( fb_Weekday( serial1, first_day_of_week ) > fb_Weekday( serial2, first_day_of_week ) )
                result += add_value;
        }
        break;
    case FB_TIME_INTERVAL_HOUR:
        serial = serial2 - serial1;
        fb_hTimeDecodeSerial ( serial, &hour, NULL, NULL, FALSE );
        result = (long long) (hour + floor(serial) * 24.0l);
        break;
    case FB_TIME_INTERVAL_MINUTE:
        serial = serial2 - serial1;
        fb_hTimeDecodeSerial ( serial, &hour, &minute, NULL, FALSE );
        result = (long long) (minute + (hour + floor(serial) * 24.0l) * 60.0l);
        break;
    case FB_TIME_INTERVAL_SECOND:
        serial = serial2 - serial1;
        fb_hTimeDecodeSerial ( serial, &hour, &minute, &second, FALSE );
        result = (long long) (second + (minute + (hour + floor(serial) * 24.0l) * 60.0l) * 60.0l);
        break;
    case FB_TIME_INTERVAL_INVALID:
    default:
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        break;
    }

    return result;
}
