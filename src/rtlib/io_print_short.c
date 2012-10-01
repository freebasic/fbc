/* print [#] function (short) */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintShort ( int fnum, short val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "% ", "hd" );
}

/*:::::*/
FBCALL void fb_PrintUShort ( int fnum, unsigned short val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "%", "hu" );
}
