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
 * time_getformat.c -- get short DATE/TIME format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"
#include <stddef.h>
#include <string.h>
#include <assert.h>
#include <langinfo.h>


/*:::::*/
int fb_hDateGetFormat( char *buffer, size_t len )
{
    char *pszDateFormat = nl_langinfo( D_FMT );
    int set_default = TRUE;

    assert(buffer!=NULL);
    if( strcmp( pszDateFormat, "%D" ) == 0 ) {
        /* set default */
    } else if( strcmp( pszDateFormat, "%F" ) == 0 ) {
        if( len < 11 )
            return FALSE;
        strcpy(buffer, "yyyy-MM-dd");
        set_default = FALSE;
    } else {
        int do_esc = FALSE, do_fmt = FALSE;
        char *pszOutput = buffer;
        char achAddBuffer[2] = { 0 };
        const char *pszAdd;
        size_t remaining = len - 1, add_len = 0;
        const char *pszStart = pszDateFormat;
        while ( *pszStart!=0 ) {
            char ch = *pszStart;
            if( do_esc ) {
                do_esc = FALSE;
                achAddBuffer[0] = ch;
                pszAdd = achAddBuffer;
                add_len = 1;
            } else if ( do_fmt ) {
                int succeeded = TRUE;
                do_fmt = FALSE;
                switch (ch) {
                case 'd':
                case 'e':
                    pszAdd = "dd";
                    add_len = 2;
                    break;
                case 'm':
                    pszAdd = "MM";
                    add_len = 2;
                    break;
                case 'y':
                    pszAdd = "yy";
                    add_len = 2;
                    break;
                case 'Y':
                    pszAdd = "yyyy";
                    add_len = 4;
                    break;
                case '%':
                    pszAdd = "%";
                    add_len = 1;
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
            ++pszStart;
        }
        set_default = *pszStart!=0;
    }
    if( set_default ) {
        if( len < 11 )
            return FALSE;
        strcpy(buffer, "MM/dd/yyyy");
    }
    return TRUE;
}
