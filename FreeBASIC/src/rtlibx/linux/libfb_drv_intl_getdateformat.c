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

#include "fbext.h"
#include <stddef.h>
#include <string.h>
#include <assert.h>
#include <langinfo.h>


/*:::::*/
int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
    
{
    int do_esc = FALSE, do_fmt = FALSE;
    char *pszOutput = buffer;
    char achAddBuffer[2] = { 0 };
    const char *pszAdd = NULL;
    size_t remaining = len - 1, add_len = 0;
    const char *pszCurrent = nl_langinfo( D_FMT );

    assert(buffer!=NULL);

    while ( *pszCurrent!=0 ) {
        char ch = *pszCurrent;
        if( do_esc ) {
            do_esc = FALSE;
            achAddBuffer[0] = ch;
            pszAdd = achAddBuffer;
            add_len = 1;
        } else if ( do_fmt ) {
            int succeeded = TRUE;
            do_fmt = FALSE;
            switch (ch) {
            case 'n':
                pszAdd = "\n";
                add_len = 1;
                break;
            case 't':
                pszAdd = "\t";
                add_len = 1;
                break;
            case '%':
                pszAdd = "%";
                add_len = 1;
                break;

            case 'a':
                pszAdd = "ddd";
                add_len = 3;
                break;
            case 'A':
                pszAdd = "dddd";
                add_len = 4;
                break;
            case 'h':
            case 'b':
                pszAdd = "mmm";
                add_len = 3;
                break;
            case 'B':
                pszAdd = "mmmm";
                add_len = 4;
                break;
            case 'd':
            case 'e':
                pszAdd = "dd";
                add_len = 2;
                break;
            case 'F':
                pszAdd = "yyyy-MM-dd";
                add_len = 10;
                break;
            case 'm':
                pszAdd = "MM";
                add_len = 2;
                break;
            case 'D':
            case 'x':
                pszAdd = "MM/dd/yyyy";
                add_len = 10;
                break;
            case 'y':
                pszAdd = "yy";
                add_len = 2;
                break;
            case 'Y':
                pszAdd = "yyyy";
                add_len = 4;
                break;
            default:
                /* Unsupported format */
                succeeded = FALSE;
                break;
            }
            if( !succeeded )
                break;
        } else {
            switch (ch) {
            case '%':
                do_fmt = TRUE;
                break;
            case '\\':
                do_esc = TRUE;
                break;
            default:
                achAddBuffer[0] = ch;
                pszAdd = achAddBuffer;
                add_len = 1;
                break;
            }
        }
        if( add_len!=0 ) {
            if( remaining < add_len ) {
                return FALSE;
            }
            strcpy( pszOutput, pszAdd );
            pszOutput += add_len;
            remaining -= add_len;
            add_len = 0;
        }
        ++pszCurrent;
    }

    return TRUE;
}
