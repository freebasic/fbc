#include "../fb.h"
#include <windows.h>

int fb_hSetDate( int y, int m, int d )
{
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
}
