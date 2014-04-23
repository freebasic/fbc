#include "fb_gfx.h"

FBCALL void fb_GfxPaletteUsing64(long long *data)
{
	int i;

	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (__fb_gfx->depth > 8)) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	DRIVER_LOCK();

	for (i = 0; i < (1 << __fb_gfx->depth); i++) {
		if (data[i] >= 0)
			fb_hSetPaletteColor(i, (int)data[i]);
	}

	fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h);

	DRIVER_UNLOCK();

	FB_GRAPHICS_UNLOCK( );
}
