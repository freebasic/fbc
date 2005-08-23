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
 * drv_intl_getmonthname.c -- get localized month name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fbext_dos.h"

/*:::::*/
FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    FBSTRING *result = NULL;
    size_t i;
    DOS_COUNTRY_INFO_GENERAL Info;

    if( !fb_hIntlGetInfo( &Info ) )
        return NULL;

    for( i=0; i!=fb_locale_info_count; ++i) {
        const FB_LOCALE_INFOS *info = fb_locale_infos + i;
        if( info->country_code==Info.country_id ) {
            const char *name = ( short_names ? info->apszNamesMonthShort[month-1] : info->apszNamesMonthLong[month-1] );
            result = fb_StrAllocTempDescZ( name );
            break;
        }
    }

    return result;
}
