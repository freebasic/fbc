/* week functions */

#include "fb.h"
#include <math.h>

/*:::::*/
void fb_hGetBeginOfWeek( int *pYear, int *pMonth, int *pDay,
                         int first_day_of_week )
{
    double serial;
    int weekday;

    serial = fb_DateSerial( *pYear, *pMonth, *pDay );
    weekday = fb_Weekday( serial, first_day_of_week );
    serial -= weekday - 1;

    fb_hDateDecodeSerial( serial, pYear, pMonth, pDay );
}

/*:::::*/
double fb_hGetFirstWeekOfYear( int year,
                               int first_day_of_year, int first_day_of_week )
{
    int first_week_year, first_week_month, first_week_day;
    double serial_week_begin, serial_year_begin;
    int remaining_weekdays;

    if( first_day_of_year==FB_WEEK_FIRST_SYSTEM ) {
        /* FIXME: query system default */
        first_day_of_year = FB_WEEK_FIRST_DEFAULT;
    }

    serial_year_begin = fb_DateSerial( year, 1, 1 );

    first_week_day = 1;
    first_week_month = 1;
    first_week_year = year;
    fb_hGetBeginOfWeek( &first_week_year, &first_week_month, &first_week_day,
                        first_day_of_week );

    serial_week_begin = fb_DateSerial( first_week_year,
                                       first_week_month,
                                       first_week_day );
    remaining_weekdays = (int) ((serial_week_begin + 7.0l) - serial_year_begin);

    switch( first_day_of_year ) {
    case FB_WEEK_FIRST_JAN_1:
        break;
    case FB_WEEK_FIRST_FOUR_DAYS:
        if( remaining_weekdays < 4 ) {
            serial_week_begin += 7.0l;
        }
        break;
    case FB_WEEK_FIRST_FULL_WEEK:
        if( remaining_weekdays < 7 ) {
            serial_week_begin += 7.0l;
        }
        break;
    }

    return serial_week_begin;
}

/*:::::*/
int fb_hGetWeekOfYear( int ref_year, double serial,
                       int first_day_of_year, int first_day_of_week )
{
    int sign;
    int year, week;
    double serial_first_week;

    fb_hDateDecodeSerial( serial, &year, NULL, NULL );

    serial_first_week =
        fb_hGetFirstWeekOfYear( ref_year,
                                first_day_of_year, first_day_of_week );

    serial = floor( serial - serial_first_week);
    sign = fb_hSign( serial );
    serial /= 7.0l;
    week = (int) (serial + sign);

    return week;
}

/*:::::*/
int fb_hGetWeeksOfYear( int ref_year, int first_day_of_year, int first_day_of_week )
{
    double serial_start =
        fb_hGetFirstWeekOfYear( ref_year,
                                first_day_of_year, first_day_of_week );
    double serial_end =
        fb_hGetFirstWeekOfYear( ref_year + 1,
                                first_day_of_year, first_day_of_week );
    return (int) ((serial_end - serial_start) / 7.0l);
}
