/* returns the month name */

#include "fb.h"

/*:::::*/
FBCALL FBSTRING *fb_MonthName( int month, int abbreviation )
{
    FBSTRING *res;

    if( month < 1 || month > 12 ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        return &__fb_ctx.null_desc;
    }

    fb_ErrorSetNum( FB_RTERROR_OK );

    res = fb_IntlGetMonthName( month, abbreviation, FALSE );
    if( res==NULL ) {
        fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
        res = &__fb_ctx.null_desc;
    }

    return res;
}
