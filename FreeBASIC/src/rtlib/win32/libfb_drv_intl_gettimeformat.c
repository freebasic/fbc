/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2010 The FreeBASIC development team.
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
 * time_getformat.c -- get short TIME format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <stdlib.h>
#include <string.h>
#include "fb.h"


/*:::::*/
int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
    char achFormat[90], *pszFormat;
    char achHourZero[8], *pszHourZero;
    char achTimeMark[8], *pszTimeMark;
    char achTimeMarkPos[8], *pszTimeMarkPos;
    int use_timemark, timemark_prefix;
    size_t i;

    DBG_ASSERT(buffer!=NULL);

    /* Can I use this? The problem is that it returns the date format
     * with localized separators. */
    pszFormat = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_STIMEFORMAT,
                                   achFormat, sizeof(achFormat) - 1 );
    if( pszFormat!=NULL ) {
        size_t uiNameSize = strlen(pszFormat);
        if( uiNameSize < len ) {
            strcpy( buffer, pszFormat );
            return TRUE;
        } else {
            return FALSE;
        }
    }


    /* Fall back for Win95 and WinNT < 4.0 */
    pszTimeMarkPos = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_ITIMEMARKPOSN,
                                        achTimeMarkPos, sizeof(achTimeMarkPos) );
    pszTimeMark = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_ITIME,
                                     achTimeMark, sizeof(achTimeMark) );
    pszHourZero = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_ITLZERO,
                                     achHourZero, sizeof(achHourZero) );

    i = 0;

    use_timemark = ( pszTimeMark!=NULL && atoi( pszTimeMark )==1 );
    timemark_prefix = ( pszTimeMarkPos!=NULL && atoi( pszTimeMarkPos )==1 );

    if( use_timemark && timemark_prefix ) {
        strcpy( achFormat + i, "AM/PM " );
        i += 6;
    }

    if( pszHourZero!=NULL && atoi( pszHourZero )==1 ) {
        if( !use_timemark ) {
            strcpy( achFormat + i, "HH:" );
        } else {
            strcpy( achFormat + i, "hh:" );
        }
        i += 3;
    }
    strcpy( achFormat + i, "mm:ss" );
    i += 5;

    if( use_timemark && !timemark_prefix ) {
        strcpy( achFormat + i, " AM/PM" );
        i += 6;
    }

    if( len < (i+1) )
        return FALSE;

    FB_MEMCPY(buffer, achFormat, i);
    buffer[i] = 0;

    return TRUE;
}
