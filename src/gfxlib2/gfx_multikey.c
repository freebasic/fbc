/* MULTIKEY function for multiple keypresses detection. */

#include "fb_gfx.h"

int fb_GfxMultikey(int scancode)
{
	int result = FB_FALSE;

	FB_GRAPHICS_LOCK( );

	if ((__fb_gfx) && (scancode >= 0) && (scancode < 128)) {
		DRIVER_LOCK();
		result = (__fb_gfx->key[scancode]? FB_TRUE : FB_FALSE);
		DRIVER_UNLOCK();
	}

	FB_GRAPHICS_UNLOCK( );

	return result;
}
