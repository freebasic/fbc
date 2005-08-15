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
 * time_monthname.c -- returns the month name
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fbext.h"

/*:::::*/
FBCALL FBSTRING *fb_MonthName( int month, int abbreviation )
{
    FBSTRING *res;

    if( month < 1 || month > 12 ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        return &fb_strNullDesc;
    }

    fb_ErrorSetNum( FB_RTERROR_OK );

    FB_LOCK();

    res = fb_IntlGetMonthName( month, abbreviation, FALSE );
    if( res==NULL ) {
        FB_UNLOCK();
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        return &fb_strNullDesc;
    }

    FB_UNLOCK();

    return res;
}
