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

#include <stdlib.h>
#include <string.h>
#include "fbext.h"

/*:::::*/
FBSTRING *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    char *pszName = NULL;
    size_t name_len;
    LCTYPE lctype;
    FBSTRING *result;

    if( weekday < 1 || weekday > 7 )
        return NULL;

    if( weekday==1 )
        weekday = 8;

    if( short_names ) {
        lctype = (LCTYPE) (LOCALE_SABBREVDAYNAME1 + weekday - 2);
    } else {
        lctype = (LCTYPE) (LOCALE_SDAYNAME1 + weekday - 2);
    }

    pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, lctype,
                                 NULL, 0 );
    if( pszName==NULL )
        return NULL;

    name_len = strlen(pszName);

    FB_STRLOCK();

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        int target_cp = ( FB_GFX_ACTIVE() ? FB_GFX_GET_CODEPAGE() : GetConsoleCP() );
        if( target_cp!=-1 ) {
            FB_MEMCPY( result->data, pszName, name_len + 1 );
            result = fb_hIntlConvertString( result,
                                            CP_ACP,
                                            target_cp );
        }
    }

    FB_STRUNLOCK();

    free( pszName );

    return result;
}
