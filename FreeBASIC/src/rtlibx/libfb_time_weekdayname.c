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
 * time_weekdayname.c -- returns the weekday name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fbext.h"

/*:::::*/
FBCALL FBSTRING *fb_WeekdayName( int weekday, int abbreviation, int first_day_of_week )
{
    FBSTRING *res;

    if( weekday < 1 || weekday > 7 || first_day_of_week < 0 || first_day_of_week > 7 ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        return &fb_strNullDesc;
    }

    fb_ErrorSetNum( FB_RTERROR_OK );

    if( first_day_of_week==FB_WEEK_DAY_SYSTEM ) {
        /* FIXME: Add query of system default */
        first_day_of_week = FB_WEEK_DAY_DEFAULT;
    }

    weekday += first_day_of_week - 1;
    if( weekday > 7 )
        weekday -= 7;

    res = fb_IntlGetWeekdayName( weekday, abbreviation, FALSE );
    if( res==NULL ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        res = &fb_strNullDesc;
    }

    return res;
}
