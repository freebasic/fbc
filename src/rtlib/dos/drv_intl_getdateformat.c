/* get localized short DATE format */

#include "../fb.h"
#include "fb_private_intl.h"

int fb_DrvIntlGetDateFormat( char *buffer, size_t len )
{
    DOS_COUNTRY_INFO_GENERAL Info;

    if( len < 11 )
        return FALSE;
    if( !fb_hIntlGetInfo( &Info ) )
        return FALSE;

    switch( Info.date_format ) {
    case 0:
        strcpy( buffer, "MM/dd/yyyy" );
        break;
    case 1:
        strcpy( buffer, "dd/MM/yyyy" );
        break;
    case 2:
        strcpy( buffer, "yyyy/MM/dd" );
        break;
    default:
        return FALSE;
    }

    return TRUE;
}
