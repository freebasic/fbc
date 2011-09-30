/* returns the weekday name */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_WeekdayName( int weekday, int abbreviation, int first_day_of_week )
{
    FBSTRING *res;

    if( weekday < 1 || weekday > 7 || first_day_of_week < 0 || first_day_of_week > 7 ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        return &__fb_ctx.null_desc;
    }

    fb_ErrorSetNum( FB_RTERROR_OK );

    if( first_day_of_week==FB_WEEK_DAY_SYSTEM ) {
        /* FIXME: Add query of system default */
        first_day_of_week = FB_WEEK_DAY_DEFAULT;
    }

    weekday += first_day_of_week - 1;
    if( weekday > 7 )
        weekday -= 7;

    res = fb_IntlGetWeekdayName( weekday, abbreviation, FALSE );
    if( res==NULL ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        res = &__fb_ctx.null_desc;
    }

    return res;
}
