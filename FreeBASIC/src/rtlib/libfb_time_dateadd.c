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
 * time_dateadd.c -- dateadd functions
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "fb.h"
#include "fb_rterr.h"

FBCALL double fb_DateAdd( FBSTRING *interval, double interval_value_arg, double serial )
{
    int year, month, day, hour, minute, second;
    int carry_value, test_value;
    int interval_value = (int) fb_FIXDouble( interval_value_arg );
    int interval_type = fb_hTimeGetIntervalType( interval );

    fb_ErrorSetNum( FB_RTERROR_OK );

    fb_hTimeDecodeSerial ( serial, &hour, &minute, &second );
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
#if 0
        /* Handle date/time wrap-arounds */
        if( second < 0 ) {
            carry_value = ((second - 59) / 60);
        } else {
            carry_value = second / 60;
        }
        minute += carry_value;
        second -= carry_value * 60;
        if( minute < 0 ) {
            carry_value = ((minute - 59) / 60);
        } else {
            carry_value = minute / 60;
        }
        hour += carry_value;
        minute -= carry_value * 60;
        if( hour < 0 ) {
            carry_value = ((hour - 23) / 24);
        } else {
            carry_value = hour / 24;
        }
        day += carry_value;
        hour -= carry_value * 24;
        fb_hNormalizeDate( &day, &month, &year );
#endif
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
    case FB_TIME_INTERVAL_DAY_OF_YEAR:
    case FB_TIME_INTERVAL_DAY:
    case FB_TIME_INTERVAL_WEEKDAY:
    case FB_TIME_INTERVAL_WEEK_OF_YEAR:
#if 0
        /* Handle normal day wrap-around */
        fb_hNormalizeDate( &day, &month, &year );
#endif
        break;

    }

    serial = fb_DateSerial( year, month, day ) +
        fb_TimeSerial( hour, minute, second );

    return serial;
}
