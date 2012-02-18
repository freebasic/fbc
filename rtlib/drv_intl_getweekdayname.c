/* get localized weekday name */

#include "fb.h"
#include "fb_private_intl.h"

#if defined( HOST_DOS )
FBSTRING *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    FBSTRING *result = NULL;
    size_t i;
    DOS_COUNTRY_INFO_GENERAL Info;

    if( !fb_hIntlGetInfo( &Info ) )
        return NULL;

    for( i=0; i!=__fb_locale_info_count; ++i) {
        const FB_LOCALE_INFOS *info = __fb_locale_infos + i;
        if( info->country_code==Info.country_id ) {
            const char *name = ( short_names ? info->apszNamesWeekdayShort[weekday-1] : info->apszNamesWeekdayLong[weekday-1] );
            result = fb_StrAllocTempDescZ( name );
            break;
        }
    }

    return result;
}

#elif defined( HOST_UNIX )
FBSTRING *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    const char *pszName;
    FBSTRING *result;
    size_t name_len;
    nl_item index;

    if( weekday < 1 || weekday > 7 )
        return NULL;

    if( short_names ) {
        index = (nl_item) (ABDAY_1 + weekday - 1);
    } else {
        index = (nl_item) (DAY_1 + weekday - 1);
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

#elif defined( HOST_WIN32 )
FBSTRING *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    char *pszName = NULL;
    size_t name_len;
    LCTYPE lctype;
    FBSTRING *result;

    if( weekday < 1 || weekday > 7 )
        return NULL;

    if( weekday==1 )
        weekday = 8;

    if( short_names ) {
        lctype = (LCTYPE) (LOCALE_SABBREVDAYNAME1 + weekday - 2);
    } else {
        lctype = (LCTYPE) (LOCALE_SDAYNAME1 + weekday - 2);
    }

    pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, lctype,
                                 NULL, 0 );
    if( pszName==NULL )
        return NULL;

    name_len = strlen(pszName);

    result = fb_hStrAllocTemp( NULL, name_len );
    if( result!=NULL ) {
        /* !!!FIXME!!! GetCodepage() should become a hook function for console and gfx modes */
        int target_cp = /*( FB_GFX_ACTIVE() ? FB_GFX_GET_CODEPAGE() : GetConsoleCP() );*/ GetConsoleCP();
        if( target_cp!=-1 ) {
            FB_MEMCPY( result->data, pszName, name_len + 1 );
            result = fb_hIntlConvertString( result,
                                            CP_ACP,
                                            target_cp );
        }
    }

   free( pszName );

    return result;
}

#else
FBSTRING *fb_DrvIntlGetWeekdayName( int weekday, int short_names )
{
    /* No localized weekday name available */
    return NULL;
}

#endif
