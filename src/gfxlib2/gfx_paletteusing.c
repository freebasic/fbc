#include "fb_gfx.h"

FBCALL void fb_GfxPaletteUsing(int *data)
{
	int i;

	if ((!__fb_gfx) || (__fb_gfx->depth > 8))
		return;

	DRIVER_LOCK();

	for (i = 0; i < (1 << __fb_gfx->depth); i++) {
		if (data[i] >= 0)
			fb_hSetPaletteColor(i, data[i]);
	}

	fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h);

	DRIVER_UNLOCK();
}
