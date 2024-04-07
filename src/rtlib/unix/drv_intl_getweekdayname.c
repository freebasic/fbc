/* get localized weekday name */

#include "../fb.h"
#ifndef DISABLE_LANGINFO
#include <langinfo.h>
#else
const char *weekday_names[] = {
    "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
};

const char *short_weekday_names[] = {
    "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
};
#endif

FBSTRING *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    const char *pszName;
    FBSTRING *result;
    size_t name_len;

    if( weekday < 1 || weekday > 7 )
        return NULL;

#ifdef DISABLE_LANGINFO
    if( short_names ) {
        pszName = short_weekday_names[weekday - 1];
    } else {
        pszName = weekday_names[weekday - 1];
    }
#else
    nl_item index;

    if( short_names ) {
        index = (nl_item) (ABDAY_1 + weekday - 1);
    } else {
        index = (nl_item) (DAY_1 + weekday - 1);
    }

    pszName = nl_langinfo( index );
    if( pszName==NULL ) {
        return NULL;
    }
#endif

    name_len = strlen( pszName );

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        FB_MEMCPY( result->data, pszName, name_len + 1 );
    }

    return result;
}
