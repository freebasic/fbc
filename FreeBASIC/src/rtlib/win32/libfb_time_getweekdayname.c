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
 * time_getweekdayname.c -- get weekday name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

static const char *pszWeekDayNamesLong[7] = {
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
};

static const char *pszWeekDayNamesShort[7] = {
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
};

/*:::::*/
const char *fb_hDateGetWeekDay( int weekday, int short_names, int localized )
{
    if( weekday < 1 || weekday > 7 )
        return NULL;

    if( localized ) {
        static char *pszName = NULL;
        LCTYPE lctype;

        if( pszName!=NULL ) {
            free( pszName );
            pszName = NULL;
        }

        if( short_names ) {
            lctype = (LCTYPE) (LOCALE_SABBREVDAYNAME1 + weekday - 1);
        } else {
            lctype = (LCTYPE) (LOCALE_SDAYNAME1 + weekday - 1);
        }

        return pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, lctype,
                                            NULL, 0 );
    }

    if( short_names )
        return pszWeekDayNamesShort[weekday-1];
    return pszWeekDayNamesLong[weekday-1];
}
