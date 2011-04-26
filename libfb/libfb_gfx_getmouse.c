/*
 * getmouse.c -- GETMOUSE function support.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxGetMouse(int *x, int *y, int *z, int *buttons, int *clip)
{
	int failure = TRUE;
	int temp_z, temp_buttons, temp_clip;

	if (!z)
		z = &temp_z;
	if (!buttons)
		buttons = &temp_buttons;
	if (!clip)
		clip = &temp_clip;
	if ((__fb_gfx) && (__fb_gfx->driver->get_mouse)) {
		DRIVER_LOCK();
		failure = __fb_gfx->driver->get_mouse(x, y, z, buttons, clip);
		DRIVER_UNLOCK();
	}
	if (failure) {
		*x = *y = *z = *buttons = *clip = -1;
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}
	return fb_ErrorSetNum( FB_RTERROR_OK );
}
