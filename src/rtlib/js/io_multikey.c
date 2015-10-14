/* console multikey() */

#include "../fb.h"
#include "fb_private_console.h"

int fb_ConsoleMultikey( int scancode )
{
	if( scancode < 0 || scancode > 255 )
        fb_ErrorSetNum( FB_RTERROR_ILLEGALFUNCTIONCALL );

	return __fb_con.multikey[scancode] != 0? FB_TRUE: FB_FALSE;
}
