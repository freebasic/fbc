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
 * drv_intl_getdateformat.c -- get localized short DATE format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <string.h>
#include "fbext_dos.h"

/*:::::*/
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    DOS_COUNTRY_INFO_GENERAL Info;

    if( len < 11 )
        return FALSE;
    if( !fb_hIntlGetInfo( &Info ) )
        return FALSE;

    switch ( Info.date_format ) {
    case 0:
        strcpy( buffer, "MM/dd/yyyy" );
        break;
    case 1:
        strcpy( buffer, "dd/MM/yyyy" );
        break;
    case 2:
        strcpy( buffer, "yyyy/MM/dd" );
        break;
    default:
        return FALSE;
    }

    return TRUE;
}
