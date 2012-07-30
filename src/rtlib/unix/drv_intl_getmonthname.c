/* get localized month name */

#include "../fb.h"
#include <langinfo.h>

FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    const char *pszName;
    FBSTRING *result;
    size_t name_len;
    nl_item index;

    if( month < 1 || month > 12 )
        return NULL;

    if( short_names ) {
        index = (nl_item) (ABMON_1 + month - 1);
    } else {
        index = (nl_item) (MON_1 + month - 1);
    }

    FB_LOCK();

    pszName = nl_langinfo( index );
    if( pszName==NULL ) {
        FB_UNLOCK();
        return NULL;
    }

    name_len = strlen( pszName );

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        FB_MEMCPY( result->data, pszName, name_len + 1 );
    }

    FB_UNLOCK();

    return result;
}
