/* print [#] function (byte) */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintByte ( int fnum, signed char val, int mask )
{
    FB_PRINTNUM( fnum, ((int) val), mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_PrintUByte ( int fnum, unsigned char val, int mask )
{
    FB_PRINTNUM( fnum, ((unsigned) val), mask, "%", "u" );
}
