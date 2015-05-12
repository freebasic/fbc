/* set time function */

#include "fb.h"
#if defined HOST_DOS
	#include <dos.h>
#elif defined HOST_UNIX
	#include <sys/time.h>
#elif defined HOST_WIN32
	#include <windows.h>
#endif

int fb_hSetTime( int h, int m, int s )
{
#if defined( HOST_DOS )
	struct time t;
	t.ti_hour = h;
	t.ti_min = m;
	t.ti_sec = s;
	t.ti_hund = 0;
	settime(&t);
	return 0;

#elif defined( HOST_UNIX )
	struct timeval tv;
	gettimeofday( &tv, NULL );
	tv.tv_sec -= (tv.tv_sec % 86400);
	tv.tv_sec += (h * 3600) + (m * 60) + s;
	if( settimeofday( &tv, NULL ) )
		return -1;
	return 0;

#elif defined( HOST_WIN32 )
	/* get current local time and date */
	SYSTEMTIME st;
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

#elif defined( HOST_XBOX )
	/* TODO: use NtSetSystemTime */
	return 0;

#else
#	error TODO
#endif
}
