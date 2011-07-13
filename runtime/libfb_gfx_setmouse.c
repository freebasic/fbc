/*
 * setmouse.c -- SETMOUSE function support.
 *
 * chng: feb/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxSetMouse(int x, int y, int cursor, int clip)
{
	if ((!__fb_gfx) || (!__fb_gfx->driver->set_mouse))
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);

	DRIVER_LOCK();
	__fb_gfx->driver->set_mouse(x, y, cursor, clip);
	DRIVER_UNLOCK();

	return fb_ErrorSetNum( FB_RTERROR_OK );
}
