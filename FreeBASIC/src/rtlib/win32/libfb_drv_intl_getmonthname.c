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
 * time_getmonthname.c -- get month name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"

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

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        /* !!!FIXME!!! GetCodepage() should become a hook function for console and gfx modes */
        int target_cp = /*( FB_GFX_ACTIVE() ? FB_GFX_GET_CODEPAGE() : GetConsoleCP() );*/ GetConsoleCP();
        if( target_cp!=-1 ) {
            FB_MEMCPY( result->data, pszName, name_len + 1 );
            result = fb_hIntlConvertString( result,
                                            CP_ACP,
                                            target_cp );
        }
    }

    free( pszName );

    return result;
}
