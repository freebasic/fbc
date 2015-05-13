/* get localized short TIME format */

#include "../fb.h"
#include "fb_private_intl.h"

int fb_DrvIntlGetTimeFormat( char *buffer, size_t len )
{
	DOS_COUNTRY_INFO_GENERAL Info;

	if( fb_hIntlGetInfo( &Info ) ) {
		switch( Info.time_format ) {
		case 0:
			if( len >= 12 ) {
				strcpy( buffer, "hh:mm:ss tt" );
				return TRUE;
			}
			break;
		case 1:
			if( len >= 9 ) {
				strcpy( buffer, "HH:mm:ss" );
				return TRUE;
			}
			break;
		}
	}

	return FALSE;
}
