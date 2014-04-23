/* retrieve whole palette into an array */

#include "fb_gfx.h"

FBCALL void fb_GfxPaletteGetUsing64(long long *data)
{
	int i, imax;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	imax = __fb_gfx->default_palette->colors;
	if(imax > (1 << __fb_gfx->depth))
		imax = (1 << __fb_gfx->depth);

	for (i = 0; i < imax; i++)
		data[i] = (__fb_gfx->device_palette[i] & 0xFCFCFC) >> 2;

	FB_GRAPHICS_UNLOCK( );
}
