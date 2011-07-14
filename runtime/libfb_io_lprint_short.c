/* print [#] function (short) */

#include <stdio.h>
#include "fb.h"


int LPrintInit(void);

/*:::::*/
FBCALL void fb_LPrintShort ( int fnum, short val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "% ", "hd" );
}

/*:::::*/
FBCALL void fb_LPrintUShort ( int fnum, unsigned short val, int mask )
{
    LPrintInit();
    mask = FB_PRINT_CONVERT_BIN_NEWLINE(mask);
    FB_PRINTNUM( fnum, val, mask, "%", "hu" );
}
