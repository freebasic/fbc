/* retrieve certain color from current palette */

#include "fb_gfx.h"

FBCALL void fb_GfxPaletteGet(int index, int *r, int *g, int *b)
{
	unsigned int color;

	if (!__fb_gfx)
		return;

	index &= (__fb_gfx->default_palette->colors - 1);
	color = __fb_gfx->device_palette[index];
	if (!g) {
		*r = (color & 0xFCFCFC) >> 2;
	}
	else {
		*r = color & 0xFF;
		*g = (color & 0xFF00) >> 8;
		*b = (color & 0xFF0000) >> 16;
	}
}
