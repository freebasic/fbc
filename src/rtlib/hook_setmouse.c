#include "fb.h"

FBCALL int fb_SetMouse( int x, int y, int cursor, int clip )
{
	int res;

	FB_LOCK();

	if( __fb_ctx.hooks.getmouseproc )
		res = __fb_ctx.hooks.setmouseproc( x, y, cursor, clip );
	else
		res = fb_ConsoleSetMouse( x, y, cursor, clip );

	FB_UNLOCK();

	return res;
}
