/* print [#] function (int) */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintInt ( int fnum, int val, int mask )
{
    fb_LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_LPrintUInt ( int fnum, unsigned int val, int mask )
{
    fb_LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "%", "u" );
}
