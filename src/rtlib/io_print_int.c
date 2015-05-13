/* print [#] function (int) */

#include "fb.h"

/*:::::*/
FBCALL void fb_PrintInt ( int fnum, int val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "% ", "d" );
}

/*:::::*/
FBCALL void fb_PrintUInt ( int fnum, unsigned int val, int mask )
{
    FB_PRINTNUM( fnum, val, mask, "%", "u" );
}
