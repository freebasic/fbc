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
 * time_parsetime.c -- parse a string time
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <ctype.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
static int fb_hCheckAMPM( const char *text, size_t *pLength )
{
    const char *text_start = text;
    int result = 0;

    /* skip WS */
    while ( isspace( *text ) )
        ++text;

    switch( *text ) {
    case 'a':
    case 'A':
        result = 1;
        ++text;
        break;
    case 'p':
    case 'P':
        result = 2;
        ++text;
        break;
    }
    if( result!=0 ) {
        char ch = *text;
        if( ch==0 ) {
            // ignore
        } else if( ch=='m' || ch=='M' ) {
            // everything's fine
            ++text;
        } else {
            result = 0;
        }
    }
    if( result!=0 ) {
        if( isalpha( *text ) )
            result = 0;
    }
    if( result!=0 ) {
        /* skip WS */
        while ( isspace( *text ) )
            ++text;
        if( pLength )
            *pLength = text - text_start;
    }
    return result;
}

/*:::::*/
int fb_hTimeParse( const char *text, size_t text_len, int *pHour, int *pMinute, int *pSecond, size_t *pLength )
{
    size_t length = 0;
    const char *text_start = text;
    int am_pm = 0;
    int result = FALSE;
    int hour = 0, minute = 0, second = 0;
    char *endptr;

    hour = strtol( text, &endptr, 10 );
    if( hour >= 0 && hour < 24 && endptr!=text) {
        int is_ampm_hour = ( hour >= 1 && hour <= 12 );
        /* skip white spaces */
        text = endptr;
        while ( isspace( *text ) )
            ++text;
        if( *text==':' ) {
            ++text;
            minute = strtol( text, &endptr, 10 );
            if( minute >= 0 && minute < 60 && endptr!=text ) {
                text = endptr;
                while ( isspace( *text ) )
                    ++text;

                result = TRUE;
                if( *text==':' ) {
                    ++text;
                    second = strtol( text, &endptr, 10 );
                    if( endptr!=text ) {
                        if( second < 0 || second > 59 ) {
                            result = FALSE;
                        } else {
                            text = endptr;
                        }
                    } else {
                        result = FALSE;
                    }
                }
                if( result && is_ampm_hour ) {
                    am_pm = fb_hCheckAMPM( text, &length );
                    if( am_pm ) {
                        text += length;
                    }
                }
            }
        } else if( is_ampm_hour ) {
            am_pm = fb_hCheckAMPM( text, &length );
            if( am_pm ) {
                text += length;
                result = TRUE;
            }
        }
    }
    if( result ) {
        if( am_pm ) {
            /* test for AM/PM */
            if( hour==12 ) {
                if( am_pm==1 )
                    hour -= 12;
            } else {
                if( am_pm==2 )
                    hour += 12;
            }
        }
        /* Update used length */
        length = text - text_start;
    }

    if( result ) {
        if( pHour )
            *pHour = hour;
        if( pMinute )
            *pMinute = minute;
        if( pSecond )
            *pSecond = second;
        if( pLength )
            *pLength = length;
    }

    return result;
}
