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
 * time_dateserial.c -- dateserial function
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fbext.h"

/*:::::*/
FBCALL int fb_DateSerial ( int year, int month, int day )
{
    int result = 2;
    int cur_year = 1900;
    int cur_month = 1;
    int cur_day = 1;

    fb_hNormalizeDate( &day, &month, &year );

    if( cur_year < year ) {
        while( cur_year != year ) {
            result += fb_hTimeDaysInYear( cur_year++ );
        }
    } else {
        while( cur_year != year ) {
            result -= fb_hTimeDaysInYear( --cur_year );
        }
    }

    while( cur_month != month ) {
        result += fb_hTimeDaysInMonth( cur_month++, year );
    }

    result += day - cur_day;

	return result;
}

