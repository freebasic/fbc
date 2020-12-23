/* print [#] function (byte) */

#include "fb.h"

/*:::::*/
FBCALL void fb_LPrintByte ( int fnum, signed char val, int mask )
{
    fb_LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, ((int) val), mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_LPrintUByte ( int fnum, unsigned char val, int mask )
{
    fb_LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, ((unsigned) val), mask, "%", "u" );
}
