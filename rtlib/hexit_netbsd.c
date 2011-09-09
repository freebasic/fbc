/* end helper for NetBSD */

#include "fb.h"

/*:::::*/
void fb_hEnd ( int unused )
{
	fb_unix_hEnd( unused );
}
