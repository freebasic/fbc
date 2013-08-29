/* retrieve whole palette into an array */

#include "fb_gfx.h"

FBCALL void fb_GfxPaletteGetUsing(int *data)
{
	int i, imax;

	if (!__fb_gfx)
		return;

	imax = __fb_gfx->default_palette->colors;
	if(imax > (1 << __fb_gfx->depth))
		imax = (1 << __fb_gfx->depth);

	for (i = 0; i < imax; i++)
		data[i] = (__fb_gfx->device_palette[i] & 0xFCFCFC) >> 2;
}
