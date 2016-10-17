/* get localized month name */

#include "../fb.h"
#ifndef DISABLE_LANGINFO
#include <langinfo.h>
#else
const char *month_names[] = {
    "January", "February", "March", "April", "May", "June", "July", "August",
    "September", "October", "November", "December"
};

const char *short_month_names[] = {
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
};
#endif

FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    const char *pszName;
    FBSTRING *result;
    size_t name_len;

    if( month < 1 || month > 12 )
        return NULL;

#ifdef DISABLE_LANGINFO
    if( short_names ) {
        pszName = short_month_names[month - 1];
    } else {
        pszName = month_names[month - 1];
    }
#else
    nl_item index;

    if( short_names ) {
        index = (nl_item) (ABMON_1 + month - 1);
    } else {
        index = (nl_item) (MON_1 + month - 1);
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
