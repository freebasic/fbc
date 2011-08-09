/* isdate function */

#include "fb.h"

/*:::::*/
FBCALL int fb_IsDate ( FBSTRING *s )
{
    int year;
    int month;
    int day;
    int succeeded = fb_DateParse( s, &day, &month, &year );

    fb_hStrDelTemp( s );

    if( !succeeded )
			return 0;

		return -1;
}
