/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 *
 *  As a special exception, the copyright holders of this library give
 *  you permission to link this library with independent modules to
 *  produce an executable, regardless of the license terms of these
 *  independent modules, and to copy and distribute the resulting
 *  executable under terms of your choice, provided that you also meet,
 *  for each linked independent module, the terms and conditions of the
 *  license of that module. An independent module is a module which is
 *  not derived from or based on this library. If you modify this library,
 *  you may extend this exception to your version of the library, but
 *  you are not obligated to do so. If you do not wish to do so, delete
 *  this exception statement from your version.
 */

/*
 * time_datepart.c -- datepart function
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"

/*:::::*/
FBCALL int fb_DatePart( FBSTRING *interval, double serial, int first_day_of_week, int first_day_of_year )
{
    int result = 0;
    int year, month, day, hour, minute, second;
    int interval_type = fb_hTimeGetIntervalType( interval );

    fb_ErrorSetNum( FB_RTERROR_OK );

    switch ( interval_type ) {
    case FB_TIME_INTERVAL_YEAR:
        fb_hDateDecodeSerial ( serial, &year, NULL, NULL );
        result = year;
        break;
    case FB_TIME_INTERVAL_QUARTER:
        fb_hDateDecodeSerial ( serial, NULL, &month, NULL );
        result = ((month - 1) / 3) + 1;
        break;
    case FB_TIME_INTERVAL_MONTH:
        fb_hDateDecodeSerial ( serial, NULL, &month, NULL );
        result = month;
        break;
    case FB_TIME_INTERVAL_DAY_OF_YEAR:
        fb_hDateDecodeSerial ( serial, &year, &month, &day );
        result = fb_hGetDayOfYearEx( year, month, day );
        break;
    case FB_TIME_INTERVAL_DAY:
        fb_hDateDecodeSerial ( serial, NULL, NULL, &day );
        result = day;
        break;
    case FB_TIME_INTERVAL_WEEKDAY:
        result = fb_Weekday( serial, first_day_of_week );
        break;
    case FB_TIME_INTERVAL_WEEK_OF_YEAR:
        fb_hDateDecodeSerial ( serial, &year, NULL, NULL );
        result = fb_hGetWeekOfYear( year, serial, first_day_of_year, first_day_of_week );
        if( result < 0 )
            result = fb_hGetWeekOfYear( year - 1, serial, first_day_of_year, first_day_of_week );
        break;
    case FB_TIME_INTERVAL_HOUR:
        fb_hTimeDecodeSerial ( serial, &hour, NULL, NULL, FALSE );
        result = hour;
        break;
    case FB_TIME_INTERVAL_MINUTE:
        fb_hTimeDecodeSerial ( serial, NULL, &minute, NULL, FALSE );
        result = minute;
        break;
    case FB_TIME_INTERVAL_SECOND:
        fb_hTimeDecodeSerial ( serial, NULL, NULL, &second, FALSE );
        result = second;
        break;
    case FB_TIME_INTERVAL_INVALID:
    default:
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );
        break;
    }

    return result;
}
