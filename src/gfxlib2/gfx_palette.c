/* palette management */

#include "fb_gfx.h"

static const unsigned char cga_association[5][4] = {
 {  0, 11, 13, 15 }, {  0, 10, 12, 14 }, {  0,  3,  5,  7 }, {  0,  2,  4,  6 }, {  0, 15 }
};
static const unsigned char ega_association[2][16] = {
 {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 },
 {  0,  1,  2,  3,  4,  5, 20,  7, 56, 57, 58, 59, 60, 61, 62, 63 }
};

unsigned int fb_hMakeColor(int bpp, unsigned int index, int r, int g, int b)
{
	unsigned int color;

	if (bpp == 2)
		color = (b >> 3) | ((g << 3) & 0x07E0) | ((r << 8) & 0xF800);
	else
		color = index;

	return color;
}

unsigned int fb_hFixColor(int bpp, unsigned int color)
{
	return fb_hMakeColor(bpp, color, (color >> 16) & 0xFF, (color >> 8) & 0xFF, color & 0xFF) & BPP_MASK(bpp);
}

void fb_hRestorePalette(void)
{
	int i;

	if (!__fb_gfx->driver->set_palette)
		return;

	for (i = 0; i < 256; i++) {
		__fb_gfx->driver->set_palette(i, (__fb_gfx->device_palette[i] & 0xFF),
						(__fb_gfx->device_palette[i] >> 8) & 0xFF,
						(__fb_gfx->device_palette[i] >> 16) & 0xFF);
	}
}

void fb_hSetPaletteColorRgb(int index, int r, int g, int b)
{
	index &= (__fb_gfx->default_palette->colors - 1);

	__fb_gfx->device_palette[index] = r | (g << 8) | (b << 16);

	if (__fb_gfx->driver->set_palette)
		__fb_gfx->driver->set_palette(index, r, g, b);
}

void fb_hSetPaletteColor(int index, unsigned int color)
{
	int r, g, b;

	index &= (__fb_gfx->default_palette->colors - 1);

	if (__fb_gfx->default_palette == &__fb_palette[FB_PALETTE_256]) {
		r = ((color & 0x3F) * 255.0) / 63.0;
		g = (((color & 0x3F00) >> 8) * 255.0) / 63.0;
		b = (((color & 0x3F0000) >> 16) * 255.0) / 63.0;
	} else {
		color &= (__fb_gfx->default_palette->colors - 1);
		r = (__fb_gfx->palette[color] & 0xFF);
		g = (__fb_gfx->palette[color] >> 8) & 0xFF;
		b = (__fb_gfx->palette[color] >> 16) & 0xFF;
		__fb_gfx->color_association[index] = color;
	}

	fb_hSetPaletteColorRgb(index, r, g, b);
}

FBCALL void fb_GfxPalette(int index, int red, int green, int blue)
{
	int i, r, g, b;
	const PALETTE *palette;
	const unsigned char *mode_association;

	FB_GRAPHICS_LOCK( );

	if ((!__fb_gfx) || (__fb_gfx->depth > 8)) {
		FB_GRAPHICS_UNLOCK( );
		return;
	}

	DRIVER_LOCK();

	if (index < 0) {
		palette = __fb_gfx->default_palette;
		switch (__fb_gfx->mode_num) {
			case 1:
				index = MID(0, -(index + 1), 3);
				mode_association = cga_association[index];
				break;
			case 2:
				mode_association = cga_association[4];
				break;
			case 7:
			case 8:
				mode_association = ega_association[0];
				break;
			case 9:
				mode_association = ega_association[1];
				break;
			default:
				mode_association = NULL;
				break;
		}
		for (i = 0; i < palette->colors; i++) {
			r = palette->data[i * 3];
			g = palette->data[(i * 3) + 1];
			b = palette->data[(i * 3) + 2];
			__fb_gfx->palette[i] = r | (g << 8) | (b << 16);
			if (i < (1 << __fb_gfx->depth)) {
				if (mode_association) {
					__fb_gfx->color_association[i] = mode_association[i];
					r = palette->data[__fb_gfx->color_association[i] * 3];
					g = palette->data[(__fb_gfx->color_association[i] * 3) + 1];
					b = palette->data[(__fb_gfx->color_association[i] * 3) + 2];
				}
				__fb_gfx->device_palette[i] = r | (g << 8) | (b << 16);
				if (__fb_gfx->driver->set_palette)
					__fb_gfx->driver->set_palette(i, r, g, b);
			}
		}
	} else {
		if ((green < 0) || (blue < 0))
			fb_hSetPaletteColor(index, (unsigned int)red);
		else
			fb_hSetPaletteColorRgb(index, red, green, blue);
	}

	fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h);

	DRIVER_UNLOCK();
	FB_GRAPHICS_UNLOCK( );
}
