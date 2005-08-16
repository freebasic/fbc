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

#include "fbext.h"
#include <stddef.h>
#include <string.h>
#include <assert.h>
#include <langinfo.h>

/*:::::*/
FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    const char *pszName;
    FBSTRING *result;
    size_t name_len;
    nl_item index;

    if( month < 1 || month > 12 )
        return NULL;

    if( short_names ) {
        index = (nl_item) (ABMON_1 + month - 1);
    } else {
        index = (nl_item) (MON_1 + month - 1);
    }

    FB_LOCK();

    pszName = nl_langinfo( index );
    if( pszName==NULL ) {
        FB_UNLOCK();
        return NULL;
    }

    name_len = strlen( pszName );

    FB_STRLOCK();

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        FB_MEMCPY( result->data, pszName, name_len + 1 );
    }

    FB_STRUNLOCK();

    FB_UNLOCK();

    return result;
}
