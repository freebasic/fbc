#include "../fb.h"
#include <dos.h>

int fb_hSetDate( int y, int m, int d )
{
	struct date dt;
	dt.da_year = y;
	dt.da_mon = m;
	dt.da_day = d;
	setdate(&dt);
	return 0;
}
