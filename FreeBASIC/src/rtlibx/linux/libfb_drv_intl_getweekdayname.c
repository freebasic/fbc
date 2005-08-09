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
 * drv_intl_getweekdayname.c -- get localized weekday name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fbext.h"
#include <stddef.h>
#include <string.h>
#include <assert.h>
#include <langinfo.h>

/*:::::*/
const char *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    nl_item index;

    if( weekday < 1 || weekday > 7 )
        return NULL;

    if( short_names ) {
        index = (nl_item) (ABDAY_1 + weekday - 1);
    } else {
        index = (nl_item) (DAY_1 + weekday - 1);
    }
    return nl_langinfo( index );
}
