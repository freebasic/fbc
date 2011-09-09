/* turns internationalization on/off and queries status */

#include "fb.h"

static int intl_on = TRUE;

/*:::::*/
FBCALL void fb_I18nSet( int on_off )
{
    intl_on = on_off!=0;
}

/*:::::*/
FBCALL int fb_I18nGet( void )
{
    return intl_on;
}
