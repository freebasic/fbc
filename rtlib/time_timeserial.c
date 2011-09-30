/* timeserial function */

#include "fb.h"

/*:::::*/
FBCALL double fb_TimeSerial ( int hour, int minute, int second )
{
    double dblHour = 1.0 * (double) hour / 24.0;
    double dblMinute = 1.0 * minute / (24.0 * 60.0);
    double dblSecond = 1.0 * second / (24.0 * 60.0 * 60.0);
    return dblHour + dblMinute + dblSecond;
}

