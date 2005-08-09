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
 * intl_getweekdayname.c -- get weekday name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fbext.h"

static const char *pszWeekdayNamesLong[7] = {
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
};

static const char *pszWeekdayNamesShort[7] = {
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
};

/*:::::*/
const char *fb_IntlGetWeekdayName( int weekday, int short_names, int disallow_localized )
{
    if( weekday < 1 || weekday > 7 )
        return NULL;
    if( fb_I18nGet() && !disallow_localized ) {
        const char *pszName = fb_DrvIntlGetWeekdayName( weekday, short_names );
        if( pszName!=NULL )
            return pszName;
    }
    if( short_names )
        return pszWeekdayNamesShort[weekday-1];
    return pszWeekdayNamesLong[weekday-1];
}
