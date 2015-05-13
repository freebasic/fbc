/* get localized month name */

#include "../fb.h"
#include "fb_private_intl.h"

FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    FBSTRING *result = NULL;
    size_t i;
    DOS_COUNTRY_INFO_GENERAL Info;

    if( !fb_hIntlGetInfo( &Info ) )
        return NULL;

    for( i=0; i!=__fb_locale_info_count; ++i) {
        const FB_LOCALE_INFOS *info = __fb_locale_infos + i;
        if( info->country_code==Info.country_id ) {
            const char *name = ( short_names ? info->apszNamesMonthShort[month-1] : info->apszNamesMonthLong[month-1] );
            result = fb_StrAllocTempDescZ( name );
            break;
        }
    }

    return result;
}
