/* get localized weekday name */

#include "../fb.h"
#include "fb_private_intl.h"

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
