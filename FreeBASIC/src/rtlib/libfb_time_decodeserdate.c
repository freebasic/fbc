/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre V. T. Vicentini (av1ctor@yahoo.com.br) and others.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * time_decodeserdate.c -- functions to decode a serial date number
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "fb.h"

/*:::::*/
FBCALL void fb_hDateDecodeSerial ( double serial,
                                   int *pYear, int *pMonth, int *pDay )
{
    int tmp_days;
    int cur_year = 1900;
    int cur_month = 1;
    int cur_day = 1;

    serial = floor( serial );

    serial -= 2;
    while( serial < 0 ) {
        serial += fb_hTimeDaysInYear( --cur_year );
    }

    while( serial >= (tmp_days = fb_hTimeDaysInYear( cur_year ) ) ) {
        serial -= tmp_days;
        ++cur_year;
    }

    if( pMonth || pDay ) {
        while( serial >= (tmp_days = fb_hTimeDaysInMonth( cur_month, cur_year ) ) ) {
            serial -= tmp_days;
            ++cur_month;
        }
    }

    cur_day += serial;

    if( pYear )
        *pYear = cur_year;
    if( pMonth )
        *pMonth = cur_month;
    if( pDay )
        *pDay = cur_day;
}

FBCALL int fb_Year( double serial )
{
    int year;
    fb_hDateDecodeSerial( serial, &year, NULL, NULL );
    return year;
}

FBCALL int fb_Month( double serial )
{
    int month;
    fb_hDateDecodeSerial( serial, NULL, &month, NULL );
    return month;
}

FBCALL int fb_Day( double serial )
{
    int day;
    fb_hDateDecodeSerial( serial, NULL, NULL, &day );
    return day;
}

/** Returns the day of week.
 *
 * @return 1 = Sunday, ... 7 = Saturday
 */
FBCALL int fb_Weekday( double serial, int first_day_of_week )
{
    int dow = ((int) (floor(serial) - 1) % 7);
    if( dow < 0 )
        dow += 7;
    dow += 1;

    if( first_day_of_week==FB_WEEK_DAY_SYSTEM ) {
        /* FIXME: query system default */
        first_day_of_week = FB_WEEK_DAY_DEFAULT;
    }

    dow -= first_day_of_week - 1;
    if( dow < 1 )
        dow += 7;
    return dow;
}

/*:::::*/
int fb_hGetDayOfYearEx( int year, int month, int day )
{
    int result = 0;
    int cur_month;
    for( cur_month=1; cur_month!=month; ++cur_month )
        result += fb_hTimeDaysInMonth( cur_month, year );
    return result + day;
}

/*:::::*/
int fb_hGetDayOfYear( double serial )
{
    int year, month, day;
    fb_hDateDecodeSerial( serial, &year, &month, &day );
    return fb_hGetDayOfYearEx( year, month, day );
}
