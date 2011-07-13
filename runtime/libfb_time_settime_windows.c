/*
 * time_settime.c -- set time function for Windows
 *
 * chng: jan/2005 written [DrV]
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include "fb.h"

/*:::::*/
int fb_hSetTime( int h, int m, int s )
{
	SYSTEMTIME st;

	/* get current local time and date */
	GetLocalTime( &st );

	/* set time fields */
	st.wHour = h;
	st.wMinute = m;
	st.wSecond = s;

	/* set system time relative to local time zone */
	if( SetLocalTime( &st ) == 0 )
	{
		return -1;
	}

	/* send WM_TIMECHANGE to all top-level windows on NT and 95/98/Me
	 * (_not_ on 2K/XP etc.) */
	/*if ((GetVersion() & 0xFF) == 4)
		SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0);*/

	return 0;
}

