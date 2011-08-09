/* get i18n data */

#include "fb.h"

/*:::::*/
const char *fb_DrvIntlGet( eFbIntlIndex Index )
{
    static char achBuffer[128];
    switch ( Index ) {
    case eFIL_DateDivider:
        if( fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_SDATE,
                               achBuffer, sizeof(achBuffer) - 1 )==0 ) {
            return NULL;
        }
        break;
    case eFIL_TimeDivider:
        if( fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_STIME,
                               achBuffer, sizeof(achBuffer) - 1 )==0 ) {
            return NULL;
        }
        break;
    case eFIL_NumDecimalPoint:
        if( fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_SDECIMAL,
                               achBuffer, sizeof(achBuffer) - 1 )==0 ) {
            return NULL;
        }
        break;
    case eFIL_NumThousandsSeparator:
        if( fb_hGetLocaleInfo( LOCALE_USER_DEFAULT, LOCALE_STHOUSAND,
                               achBuffer, sizeof(achBuffer) - 1 )==0 ) {
            return NULL;
        }
        break;
    default:
        return NULL;
    }
    return achBuffer;
}
