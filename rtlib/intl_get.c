/* get i18n data */

#include "fb.h"

/*:::::*/
const char *fb_IntlGet( eFbIntlIndex Index, int disallow_localized )
{
    if( fb_I18nGet() && !disallow_localized ) {
        const char *pszResult = fb_DrvIntlGet( Index );
        if( pszResult!=NULL ) {
            return pszResult;
        }
    }

    switch ( Index ) {
    case eFIL_DateDivider:
        return "/";
    case eFIL_TimeDivider:
        return ":";
    case eFIL_NumDecimalPoint:
        return ".";
    case eFIL_NumThousandsSeparator:
        return ",";
    }

    return NULL;
}
