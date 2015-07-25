/* write [#] function (boolean) */

#include "fb.h"

/*:::::*/
FBCALL void fb_WriteBool ( int fnum, char val, int mask )
{
	FB_WRITENUM( fnum, fb_hBoolToStr( val ), mask, "%s" );
}
