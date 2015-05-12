/* write [#] functions */

#include "fb.h"

/*:::::*/
FBCALL void fb_WriteShort ( int fnum, short val, int mask )
{
    FB_WRITENUM( fnum, val, mask, "%hd" );
}

/*:::::*/
FBCALL void fb_WriteUShort ( int fnum, unsigned short val, int mask )
{
    FB_WRITENUM( fnum, val, mask, "%hu" );
}
