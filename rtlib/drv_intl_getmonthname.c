/* get localized month name */

#include <string.h>
#include "fb.h"

#if defined( HOST_DOS )
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

#elif defined( HOST_UNIX )
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

#elif defined( HOST_WIN32 )
FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    char *pszName = NULL;
    size_t name_len;
    LCTYPE lctype;
    FBSTRING *result;

    if( month < 1 || month > 12 )
        return NULL;

    if( short_names ) {
        lctype = (LCTYPE) (LOCALE_SABBREVMONTHNAME1 + month - 1);
    } else {
        lctype = (LCTYPE) (LOCALE_SMONTHNAME1 + month - 1);
    }

    pszName = fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, lctype,
                                 NULL, 0 );
    if( pszName==NULL ) {
        return NULL;
    }

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
FBSTRING *fb_DrvIntlGetMonthName( int month, int short_names )
{
    /* No localized month name available */
    return NULL;
}

#endif
