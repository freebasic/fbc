/*
 * intl_getdateformat.c -- get short DATE format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"

/*:::::*/
int fb_IntlGetDateFormat( char *buffer, size_t len, int disallow_localized )
{
    if( fb_I18nGet( ) && !disallow_localized ) {
        if( fb_DrvIntlGetDateFormat( buffer, len ) )
            return TRUE;
    }
    if( len < 11 )
        return FALSE;
    memcpy(buffer, "MM/dd/yyyy", 11);
    return TRUE;
}
