/* print [#] function (byte) */

#include <stdio.h>
#include "fb.h"


int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintByte ( int fnum, char val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, ((int) val), mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_LPrintUByte ( int fnum, unsigned char val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, ((unsigned) val), mask, "%", "u" );
}
