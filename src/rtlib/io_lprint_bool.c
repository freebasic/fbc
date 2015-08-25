/* print [#] function (boolean) */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintBool ( int fnum, char val, int mask )
{
    fb_LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, fb_hBoolToStr( val ), mask, "%", "s" );

}
