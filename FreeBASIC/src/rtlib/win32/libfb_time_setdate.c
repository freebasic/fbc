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
 * time_setdate.c -- set date function for Windows
 *
 * chng: jan/2005 written [DrV]
 *
 */


#include <windows.h>

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_hSetDate( int y, int m, int d )
{
    SYSTEMTIME st;

   	/* get current local time and date */
   	GetLocalTime(&st);

   	/* set time fields */
   	st.wYear = y;
   	st.wMonth = m;
   	st.wDay = d;

   	/* set system time relative to local time zone */
   	SetLocalTime(&st);

   	/* send WM_TIMECHANGE to all top-level windows on NT and 95/98/Me
   	 * (_not_ on 2K/XP etc.) */
   	if ((GetVersion() & 0xFF) == 4)
		SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);

}
