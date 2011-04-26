/*
 * drv_intl_gettimeformat.c -- get localized short TIME format
 *
 * chng: aug/2005 written [mjs]
 *
 */

#include <string.h>
#include "fb.h"

/*:::::*/
int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
    DOS_COUNTRY_INFO_GENERAL Info;

    if( !fb_hIntlGetInfo( &Info ) )
        return FALSE;

    switch ( Info.time_format ) {
    case 0:
        if( len < 12 )
            return FALSE;
        strcpy( buffer, "hh:mm:ss tt" );
        break;
    case 1:
        if( len < 9 )
            return FALSE;
        strcpy( buffer, "HH:mm:ss" );
        break;
    default:
        return FALSE;
    }

    return TRUE;
}
