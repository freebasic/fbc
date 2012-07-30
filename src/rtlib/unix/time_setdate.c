#include "../fb.h"
#include <sys/time.h>

int fb_hSetDate( int y, int m, int d )
{
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
}
