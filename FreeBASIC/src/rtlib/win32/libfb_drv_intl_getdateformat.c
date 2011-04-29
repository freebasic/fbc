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
 * date_getformat.c -- get short DATE format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"


/*:::::*/
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    char *pszName;
    char achFormat[90];
    char achOrder[3] = { 0 };
    char achDayZero[2], *pszDayZero;
    char achMonZero[2], *pszMonZero;
    char achDate[2], *pszDate;
    size_t i;

    DBG_ASSERT(buffer!=NULL);

    /* Can I use this? The problem is that it returns the date format
     * with localized separators. */
    pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_SSHORTDATE,
                                 achFormat, sizeof(achFormat) - 1 );
    if( pszName!=NULL ) {
        size_t uiNameSize = strlen(pszName);
        if( uiNameSize < len ) {
            strcpy( buffer, pszName );
            return TRUE;
        } else {
            return FALSE;
        }
    }


    /* Fall back for Win95 and WinNT < 4.0 */
    pszDayZero = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_IDAYLZERO,
                                    achDayZero, sizeof(achDayZero) );
    pszMonZero = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_IMONLZERO,
                                    achMonZero, sizeof(achMonZero) );
    pszDate = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_IDATE,
                                 achDate, sizeof(achDate) );
    if( pszDate!=NULL && pszDayZero!=0 && pszMonZero!=0 ) {
        switch( atoi( pszDate ) ) {
        case 0:
            FB_MEMCPY(achOrder, "mdy", 3);
            break;
        case 1:
            FB_MEMCPY(achOrder, "dmy", 3);
            break;
        case 2:
            FB_MEMCPY(achOrder, "ymd", 3);
            break;
        default:
            break;
        }

        if( achOrder[0]!=0 ) {
            size_t remaining = len - 1;
            int day_lead_zero = atoi( pszDayZero ) != 0;
            int mon_lead_zero = atoi( pszMonZero ) != 0;
            for(i=0; i!=3; ++i) {
                const char *pszAdd = NULL;
                size_t add_len;
                switch ( achOrder[i] ) {
                case 'm':
                    if( mon_lead_zero ) {
                        pszAdd = "MM";
                    } else {
                        pszAdd = "M";
                    }
                    break;
                case 'd':
                    if( day_lead_zero ) {
                        pszAdd = "dd";
                    } else {
                        pszAdd = "d";
                    }
                    break;
                case 'y':
                    pszAdd = "yyyy";
                    break;
                }
                add_len = strlen(pszAdd);
                if( remaining < add_len )
                    return FALSE;
                strcpy( buffer, pszAdd );
                buffer += add_len;
                remaining -= add_len;
                if( i!=2 ) {
                    if( remaining==0 )
                        return FALSE;
                    strcpy( buffer, "/" );
                    buffer += 1;
                    remaining -= 1;
                }
            }
            return TRUE;
        }
    }

    return FALSE;
}
