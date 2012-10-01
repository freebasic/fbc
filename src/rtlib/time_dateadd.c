/* dateadd function */

#include "fb.h"

/*:::::*/
FBCALL double fb_DateAdd( FBSTRING *interval, double interval_value_arg, double serial )
{
    int year, month, day, hour, minute, second;
    int carry_value, test_value;
    int interval_value = (int) fb_FIXDouble( interval_value_arg );
    int interval_type = fb_hTimeGetIntervalType( interval );

    fb_ErrorSetNum( FB_RTERROR_OK );

    fb_hTimeDecodeSerial ( serial, &hour, &minute, &second, FALSE );
    fb_hDateDecodeSerial ( serial, &year, &month, &day );

    switch ( interval_type ) {
    case FB_TIME_INTERVAL_YEAR:
        year += interval_value;
        break;
    case FB_TIME_INTERVAL_QUARTER:
        month += interval_value * 3;
        break;
    case FB_TIME_INTERVAL_MONTH:
        month += interval_value;
        break;
    case FB_TIME_INTERVAL_DAY_OF_YEAR:
    case FB_TIME_INTERVAL_DAY:
    case FB_TIME_INTERVAL_WEEKDAY:
        day += interval_value;
        break;
    case FB_TIME_INTERVAL_WEEK_OF_YEAR:
        day += interval_value * 7;
        break;
    case FB_TIME_INTERVAL_HOUR:
        hour += interval_value;
        break;
    case FB_TIME_INTERVAL_MINUTE:
        minute += interval_value;
        break;
    case FB_TIME_INTERVAL_SECOND:
        second += interval_value;
        break;
    case FB_TIME_INTERVAL_INVALID:
    default:
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        break;
    }

    /* Normalize date/time */
    switch ( interval_type ) {
    case FB_TIME_INTERVAL_HOUR:
    case FB_TIME_INTERVAL_MINUTE:
    case FB_TIME_INTERVAL_SECOND:
    case FB_TIME_INTERVAL_DAY_OF_YEAR:
    case FB_TIME_INTERVAL_DAY:
    case FB_TIME_INTERVAL_WEEKDAY:
    case FB_TIME_INTERVAL_WEEK_OF_YEAR:
        /* Nothing to do here because normalization will implicitly be done
         * by the calculation of the new serial number. */
        break;

    case FB_TIME_INTERVAL_YEAR:
    case FB_TIME_INTERVAL_QUARTER:
    case FB_TIME_INTERVAL_MONTH:
        /* Handle wrap-around for month */
        if( month < 1 ) {
            carry_value = (month - 12) / 12;
        } else {
            carry_value = (month - 1) / 12;
        }
        year += carry_value;
        month -= carry_value * 12;
        /* No wrap-around ... instead we must saturate the day */
        test_value = fb_hTimeDaysInMonth( month, year );
        if( day > test_value )
            day = test_value;
        break;

    }

    serial = fb_DateSerial( year, month, day ) +
        fb_TimeSerial( hour, minute, second );

    return serial;
}
