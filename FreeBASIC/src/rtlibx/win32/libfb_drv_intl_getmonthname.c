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
 * time_getmonthname.c -- get month name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fbext.h"

/*:::::*/
FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    char *pszName = NULL;
    size_t name_len;
    LCTYPE lctype;
    FBSTRING *result;

    if( month < 1 || month > 12 )
        return NULL;

    if( short_names ) {
        lctype = (LCTYPE) (LOCALE_SABBREVMONTHNAME1 + month - 1);
    } else {
        lctype = (LCTYPE) (LOCALE_SMONTHNAME1 + month - 1);
    }

    pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, lctype,
                                 NULL, 0 );
    if( pszName==NULL ) {
        return NULL;
    }

    name_len = strlen(pszName);

    FB_STRLOCK();

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        FB_MEMCPY( result->data, pszName, name_len + 1 );
        result = fb_hIntlConvertString( result,
                                        CP_ACP,
                                        GetConsoleCP() );
    }

    FB_STRUNLOCK();

    free( pszName );

    return result;
}
