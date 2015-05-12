/* write [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_WriteInt ( int fnum, int val, int mask )
{
    FB_WRITENUM( fnum, val, mask, "%d" );
}

/*:::::*/
FBCALL void fb_WriteUInt ( int fnum, unsigned int val, int mask )
{
    FB_WRITENUM( fnum, val, mask, "%u" );
}
