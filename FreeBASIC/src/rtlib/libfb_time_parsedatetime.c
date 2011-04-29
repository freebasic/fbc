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
 * time_parsedatetime.c -- parse a string containing a date and/or time
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <ctype.h>
#include "fb.h"

/*:::::*/
FBCALL int fb_DateTimeParse( FBSTRING *s,
                             int *pDay, int *pMonth, int *pYear,
                             int *pHour, int *pMinute, int *pSecond,
                             int want_date, int want_time)
{
	
    const char *text;
    int result = FALSE;
    size_t length, text_len;

    text = s->data;
    text_len = FB_STRSIZE( s );

	if( text == NULL ) {
		return result;
	}

    if( fb_hDateParse( text, text_len, pDay, pMonth, pYear, &length ) ) {
        text += length;
        text_len -= length;

        /* skip WS */
        while( isspace( *text ) )
            ++text, --text_len;
        /* skip optional comma */
        if( *text==',' )
            ++text, --text_len;

        if( fb_hTimeParse( text, text_len, pHour, pMinute, pSecond, &length ) ) {
            text += length;
            text_len -= length;
            result = TRUE;
        } else if( !want_time ) {
            result = TRUE;
        }
    } else if( fb_hTimeParse( text, text_len, pHour, pMinute, pSecond, &length ) ) {
        text += length;
        text_len -= length;

        /* skip WS */
        while( isspace( *text ) )
            ++text, --text_len;
        /* skip optional comma */
        if( *text==',' )
            ++text, --text_len;

        if( fb_hDateParse( text, text_len, pDay, pMonth, pYear, &length ) ) {
            text += length;
            text_len -= length;
            result = TRUE;
        } else if( !want_date ) {
            result = TRUE;
        }
    }

    if( result ) {
        /* the rest of the text must consist of white spaces */
        while( *text ) {
            if( !isspace( *text++ ) ) {
                result = FALSE;
                break;
            }
        }
    }

    return result;
}

/*:::::*/
FBCALL int fb_DateParse( FBSTRING *s, int *pDay, int *pMonth, int *pYear )
{
    return fb_DateTimeParse( s,
                             pDay, pMonth, pYear,
                             NULL, NULL, NULL,
                             TRUE, FALSE );
}

/*:::::*/
FBCALL int fb_TimeParse( FBSTRING *s, int *pHour, int *pMinute, int *pSecond )
{
    return fb_DateTimeParse( s,
                             NULL, NULL, NULL,
                             pHour, pMinute, pSecond,
                             FALSE, TRUE );
}
