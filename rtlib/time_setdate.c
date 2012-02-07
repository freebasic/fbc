/* set date function */

#include "fb.h"

int fb_hSetDate( int y, int m, int d )
{
#if defined( HOST_DOS )
	struct date dt;
	dt.da_year = y;
	dt.da_mon = m;
	dt.da_day = d;
	setdate(&dt);
	return 0;

#elif defined( HOST_UNIX )
	const int month_len[12] =
	{
		2678400, 2419200, 2678400, 2592000, 2678400, 2592000,
		2678400, 2678400, 2592000, 2678400, 2592000, 2678400
	};

	struct timeval tv;
	time_t secs;
	int i;

	if( y < 1970 )
		return -1;
	gettimeofday( &tv, NULL );
	secs = tv.tv_sec % 86400;
	tv.tv_sec = 0;
	for( i = 1970; i < y; i++ ) {
		tv.tv_sec += 31536000;
		if( ((i % 4) == 0) || ((i / 400) == 0) )
			d++;
	}
	tv.tv_sec += (m * month_len[m-1]);
	if( ((y % 4) == 0) || ((y / 400) == 0) )
		d++;
	tv.tv_sec += (d * 86400) + secs;
	if( settimeofday( &tv, NULL ) )
		return -1;

	return 0;

#elif defined( HOST_WIN32 )
	/* get current local time and date */
	SYSTEMTIME st;
	GetLocalTime( &st );

	/* set time fields */
	st.wYear = y;
	st.wMonth = m;
	st.wDay = d;

	/* set system time relative to local time zone */
	if( SetLocalTime( &st ) == 0) {
		return -1;
	}

	/* send WM_TIMECHANGE to all top-level windows on NT and 95/98/Me
	 * (_not_ on 2K/XP etc.) */
	/* if ((GetVersion() & 0xFF) == 4)
		SendMessage(HWND_BROADCAST, WM_TIMECHANGE, 0, 0); */

	return 0;

#elif defined( HOST_XBOX )
	/* TODO: use NtSetSystemTime */
	return 0;
#else
#	error TODO
#endif
}
