/*
 * vgaemu.c -- VGA in/out emulation
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


static int idx = 0, shift = 2, color = 0;


/*:::::*/
int fb_GfxIn(unsigned short port)
{
	int value = -1;

	if (!__fb_gfx)
		return -1;

	switch (port) {

		case 0x3C9:
			if (__fb_gfx->depth > 8)
				break;
			value = (__fb_gfx->device_palette[idx] >> shift) & 0x3F;
			shift += 8;
			if (shift > 18) {
				shift = 2;
				idx++;
				idx &= (__fb_gfx->default_palette->colors - 1);
			}
			break;
		
		case 0x3DA:
			if (__fb_gfx->driver->wait_vsync)
				__fb_gfx->driver->wait_vsync();
			value = 8;
			break;
	}

	return value;
}


/*:::::*/
int fb_GfxOut(unsigned short port, unsigned char value)
{
	int i, r, g, b;

	if ((!__fb_gfx) || (__fb_gfx->depth > 8))
		return -1;

	switch (port) {

		case 0x3C7:
		case 0x3C8:
			idx = value & (__fb_gfx->default_palette->colors - 1);
			shift = 2;
			color = 0;
			break;

		case 0x3C9:
			color |= ((value & 0x3F) << shift);
			shift += 8;
			if (shift > 18) {
				if (__fb_gfx->default_palette == &fb_palette_256)
					fb_GfxPalette(idx, (color >> 2) & 0x3F3F3F, -1, -1);
				else {
					DRIVER_LOCK();
					r = color & 0xFF;
					g = (color >> 8) & 0xFF;
					b = (color >> 16) & 0xFF;
					__fb_gfx->palette[idx] = color;
					for (i = 0; i < (1 << __fb_gfx->depth); i++) {
						if (__fb_gfx->color_association[i] == idx) {
							__fb_gfx->device_palette[i] = color;
							if (__fb_gfx->driver->set_palette)
								__fb_gfx->driver->set_palette(i, r, g, b);
						}
					}
					fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h);
					DRIVER_UNLOCK();
				}
				shift = 2;
				color = 0;
				idx++;
				idx &= (__fb_gfx->default_palette->colors - 1);
			}
			break;
		
		default:
			return -1;
	}

	return 0;
}
