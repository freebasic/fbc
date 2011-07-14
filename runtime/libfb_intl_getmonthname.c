/* get month name */

#include "fb.h"

static const char *pszMonthNamesLong[12] = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
};

static const char *pszMonthNamesShort[12] = {
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
};

/*:::::*/
FBSTRING *fb_IntlGetMonthName( int month, int short_names, int disallow_localized )
{
    FBSTRING *res;

    if( month < 1 || month > 12 )
        return NULL;

    if( fb_I18nGet() && !disallow_localized ) {
        res = fb_DrvIntlGetMonthName( month, short_names );
        if( res!=NULL )
            return res;
    }
    if( short_names ) {
        res = fb_StrAllocTempDescZ( pszMonthNamesShort[month-1] );
    } else {
        res = fb_StrAllocTempDescZ( pszMonthNamesLong[month-1] );
    }
    if( res==&__fb_ctx.null_desc )
        return NULL;
    return res;
}
