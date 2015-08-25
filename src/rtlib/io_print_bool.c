/* print [#] function (boolean) */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintBool ( int fnum, char val, int mask )
{
    FB_PRINTNUM( fnum, fb_hBoolToStr( val ), mask, "%", "s" );
}
