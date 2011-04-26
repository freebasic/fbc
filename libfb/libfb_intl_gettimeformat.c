/*
 * intl_gettimeformat.c -- get short TIME format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include "fb.h"

/*:::::*/
int fb_IntlGetTimeFormat( char *buffer, size_t len, int disallow_localized )
{
    if( fb_I18nGet() && !disallow_localized ) {
        if( fb_DrvIntlGetTimeFormat( buffer, len ) )
            return TRUE;
    }
    if( len < 9 )
        return FALSE;
    strcpy(buffer, "HH:mm:ss");
    return TRUE;
}
