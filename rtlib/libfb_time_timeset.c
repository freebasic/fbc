/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
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
 * time_timeset.c -- settime function
 *
 * chng: jan/2005 written [DrV]
 *
 */


#ifdef WIN32
#include <windows.h>
#endif

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"
#include "fb_rterr.h"

/*:::::*/
FBCALL int fb_SetTime( FBSTRING *time )
{

/* valid formats:
   hh
   hh:mm
   hh:mm:ss

   portability warning:  assumes ASCII ordering of digit chars ('0' < '9')
*/

#ifdef WIN32
    SYSTEMTIME st;
#endif

    char *t, c;
    int i, h, m, s;

    /* get hours */
    h = 0;
	for (i = 0, t = time->data; (c = *t) && isdigit(c); t++, i += 10)
		h = h * i + c - '0';

	if (h > 23)
		return FB_RTERROR_ILLEGALFUNCTIONCALL;
	if( c != '\0' && c != ':' )
		return FB_RTERROR_ILLEGALFUNCTIONCALL;

    if (c != '\0')
    {
		/* get minutes */
     	m = 0;
     	for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
        	 m = m * i + c - '0';

     	if( m > 59 )
     		return FB_RTERROR_ILLEGALFUNCTIONCALL;
     	if( c != '\0' && c != ':' )
     		return FB_RTERROR_ILLEGALFUNCTIONCALL;

     	if (c != '\0')
     	{
     		/* get seconds */
     		s = 0;
     		for (i = 0, t++; (c = *t) && isdigit(c); t++, i += 10)
         		s = s * i + c - '0';
    	}
    }

    if ((s > 59) || (c != '\0'))
		return FB_RTERROR_ILLEGALFUNCTIONCALL;


#ifdef WIN32

    /* get current local time and date */
    GetLocalTime(&st);

    /* set time fields */
    st.wHour = h;
    st.wMinute = m;
    st.wSecond = s;

    /* set system time relative to local time zone */
    SetLocalTime(&st);

    /* send WM_TIMECHANGE to all top-level windows on NT and 95/98/Me
     * (_not_ on 2K/XP etc.) */
    if ((GetVersion() & 0xFF) == 4)
		SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);

#else   /* WIN32 */


#endif

	/* del if temp */
	fb_hStrDelTemp( time );

	return FB_RTERROR_OK;
}

