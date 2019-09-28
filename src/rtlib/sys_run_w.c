/* RUN function (wide string) */

#include "fb.h"

FBCALL int fb_Run_W( FB_WCHAR *program, FB_WCHAR *args )
{
	if( fb_ExecEx_W( program, args, FALSE ) != -1 )
		fb_End( 0 );

    return -1;
}
