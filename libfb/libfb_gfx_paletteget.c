/*
 * paletteget.c -- palette retrieving routines
 *
 * chng: may/2005 written [lillo]
 *
 */

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
