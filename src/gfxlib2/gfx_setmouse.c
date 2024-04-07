/* SETMOUSE function support. */

#include "fb_gfx.h"

int fb_GfxSetMouse(int x, int y, int cursor, int clip)
{
	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (!__fb_gfx->driver->set_mouse)) {
		FB_GRAPHICS_UNLOCK( );
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	DRIVER_LOCK();
	if( __fb_gfx->scanline_size != 1 ) {
		y *= __fb_gfx->scanline_size;
	}
	__fb_gfx->driver->set_mouse(x, y, cursor, clip);
	DRIVER_UNLOCK();

	FB_GRAPHICS_UNLOCK( );
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
