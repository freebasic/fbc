/* VGA in/out emulation */

#include "fb_gfx.h"

static int idx = 0, shift = 2, color = 0;

int fb_GfxIn(unsigned short port)
{
	int value = -1;

	FB_GRAPHICS_LOCK( );

	if (!__fb_gfx) {
		FB_GRAPHICS_UNLOCK( );
		return -1;
	}

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

	FB_GRAPHICS_UNLOCK( );
	return value;
}

int fb_GfxOut(unsigned short port, unsigned char value)
{
	int i, r, g, b;

	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (__fb_gfx->depth > 8)) {
		FB_GRAPHICS_UNLOCK( );
		return -1;
	}

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
				if (__fb_gfx->default_palette == &__fb_palette[FB_PALETTE_256])
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
			FB_GRAPHICS_UNLOCK( );
			return -1;
	}

	FB_GRAPHICS_UNLOCK( );
	return 0;
}
