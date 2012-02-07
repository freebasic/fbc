/* write [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_WriteLongint ( int fnum, long long val, int mask )
{
    FB_WRITENUM( fnum, val, mask, "%" FB_LL_FMTMOD "d" );
}

/*:::::*/
FBCALL void fb_WriteULongint ( int fnum, unsigned long long val, int mask )
{
    FB_WRITENUM( fnum, val, mask, "%" FB_LL_FMTMOD "u" );
}
