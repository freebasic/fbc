/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2011 The FreeBASIC development team.
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
 * intl_getweekdayname.c -- get weekday name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"

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
FBSTRING *fb_IntlGetWeekdayName( int weekday, int short_names, int disallow_localized )
{
    FBSTRING *res;

    if( weekday < 1 || weekday > 7 )
        return NULL;

    if( fb_I18nGet() && !disallow_localized ) {
        res = fb_DrvIntlGetWeekdayName( weekday, short_names );
        if( res!=NULL )
            return res;
    }
    if( short_names ) {
        res = fb_StrAllocTempDescZ( pszWeekdayNamesShort[weekday-1] );
    } else {
        res = fb_StrAllocTempDescZ( pszWeekdayNamesLong[weekday-1] );
    }
    if( res==&__fb_ctx.null_desc )
        return NULL;
    return res;
}
