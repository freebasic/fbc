/*
 *  libgfx2 - FreeBASIC's alternative gfx library
 *	Copyright (C) 2005 Angelo Mottola (a.mottola@libero.it)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/*
 * palette.c -- palette management
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


static const unsigned char palette_16_data[] = {
   0,   0,   0,   0,   0, 170,   0, 170,   0,   0, 170, 170, 170,   0,   0, 170,   0, 170, 170,  85,   0, 170, 170, 170,
  85,  85,  85,  85,  85, 255,  85, 255,  85,  85, 255, 255, 255,  85,  85, 255,  85, 255, 255, 255,  85, 255, 255, 255,
};

static const unsigned char palette_64_data[] = {
   0,   0,   0,   0,   0, 170,   0, 170,   0,   0, 170, 170, 170,   0,   0, 170,   0, 170, 170, 170,   0, 170, 170, 170,
   0,   0,  85,   0,   0, 255,   0, 170,  85,   0, 170, 255, 170,   0,  85, 170,   0, 255, 170, 170,  85, 170, 170, 255,
   0,  85,   0,   0,  85, 170,   0, 255,   0,   0, 255, 170, 170,  85,   0, 170,  85, 170, 170, 255,   0, 170, 255, 170,
   0,  85,  85,   0,  85, 255,   0, 255,  85,   0, 255, 255, 170,  85,  85, 170,  85, 255, 170, 255,  85, 170, 255, 255,
  85,   0,   0,  85,   0, 170,  85, 170,   0,  85, 170, 170, 255,   0,   0, 255,   0, 170, 255, 170,   0, 255, 170, 170,
  85,   0,  85,  85,   0, 255,  85, 170,  85,  85, 170, 255, 255,   0,  85, 255,   0, 255, 255, 170,  85, 255, 170, 255,
  85,  85,   0,  85,  85, 170,  85, 255,   0,  85, 255, 170, 255,  85,   0, 255,  85, 170, 255, 255,   0, 255, 255, 170,
  85,  85,  85,  85,  85, 255,  85, 255,  85,  85, 255, 255, 255,  85,  85, 255,  85, 255, 255, 255,  85, 255, 255, 255,
};

static const unsigned char palette_256_data[] = {
   0,   0,   0,   0,   0, 170,   0, 170,   0,   0, 170, 170, 170,   0,   0, 170,   0, 170, 170,  85,   0, 170, 170, 170,
  85,  85,  85,  85,  85, 255,  85, 255,  85,  85, 255, 255, 255,  85,  85, 255,  85, 255, 255, 255,  85, 255, 255, 255,
   0,   0,   0,  20,  20,  20,  32,  32,  32,  44,  44,  44,  56,  56,  56,  68,  68,  68,  80,  80,  80,  97,  97,  97,
 113, 113, 113, 129, 129, 129, 145, 145, 145, 161, 161, 161, 182, 182, 182, 202, 202, 202, 226, 226, 226, 255, 255, 255,
   0,   0, 255,  64,   0, 255, 125,   0, 255, 190,   0, 255, 255,   0, 255, 255,   0, 190, 255,   0, 125, 255,   0,  64,
 255,   0,   0, 255,  64,   0, 255, 125,   0, 255, 190,   0, 255, 255,   0, 190, 255,   0, 125, 255,   0,  64, 255,   0,
   0, 255,   0,   0, 255,  64,   0, 255, 125,   0, 255, 190,   0, 255, 255,   0, 190, 255,   0, 125, 255,   0,  64, 255,
 125, 125, 255, 157, 125, 255, 190, 125, 255, 222, 125, 255, 255, 125, 255, 255, 125, 222, 255, 125, 190, 255, 125, 157,
 255, 125, 125, 255, 157, 125, 255, 190, 125, 255, 222, 125, 255, 255, 125, 222, 255, 125, 190, 255, 125, 157, 255, 125,
 125, 255, 125, 125, 255, 157, 125, 255, 190, 125, 255, 222, 125, 255, 255, 125, 222, 255, 125, 190, 255, 125, 157, 255,
 182, 182, 255, 198, 182, 255, 218, 182, 255, 234, 182, 255, 255, 182, 255, 255, 182, 234, 255, 182, 218, 255, 182, 198,
 255, 182, 182, 255, 198, 182, 255, 218, 182, 255, 234, 182, 255, 255, 182, 234, 255, 182, 218, 255, 182, 198, 255, 182,
 182, 255, 182, 182, 255, 198, 182, 255, 218, 182, 255, 234, 182, 255, 255, 182, 234, 255, 182, 218, 255, 182, 198, 255,
   0,   0, 113,  28,   0, 113,  56,   0, 113,  85,   0, 113, 113,   0, 113, 113,   0,  85, 113,   0,  56, 113,   0,  28,
 113,   0,   0, 113,  28,   0, 113,  56,   0, 113,  85,   0, 113, 113,   0,  85, 113,   0,  56, 113,   0,  28, 113,   0,
   0, 113,   0,   0, 113,  28,   0, 113,  56,   0, 113,  85,   0, 113, 113,   0,  85, 113,   0,  56, 113,   0,  28, 113,
  56,  56, 113,  68,  56, 113,  85,  56, 113,  97,  56, 113, 113,  56, 113, 113,  56,  97, 113,  56,  85, 113,  56,  68,
 113,  56,  56, 113,  68,  56, 113,  85,  56, 113,  97,  56, 113, 113,  56,  97, 113,  56,  85, 113,  56,  68, 113,  56,
  56, 113,  56,  56, 113,  68,  56, 113,  85,  56, 113,  97,  56, 113, 113,  56,  97, 113,  56,  85, 113,  56,  68, 113,
  80,  80, 113,  89,  80, 113,  97,  80, 113, 105,  80, 113, 113,  80, 113, 113,  80, 105, 113,  80,  97, 113,  80,  89,
 113,  80,  80, 113,  89,  80, 113,  97,  80, 113, 105,  80, 113, 113,  80, 105, 113,  80,  97, 113,  80,  89, 113,  80,
  80, 113,  80,  80, 113,  89,  80, 113,  97,  80, 113, 105,  80, 113, 113,  80, 105, 113,  80,  97, 113,  80,  89, 113,
   0,   0,  64,  16,   0,  64,  32,   0,  64,  48,   0,  64,  64,   0,  64,  64,   0,  48,  64,   0,  32,  64,   0,  16,
  64,   0,   0,  64,  16,   0,  64,  32,   0,  64,  48,   0,  64,  64,   0,  48,  64,   0,  32,  64,   0,  16,  64,   0,
   0,  64,   0,   0,  64,  16,   0,  64,  32,   0,  64,  48,   0,  64,  64,   0,  48,  64,   0,  32,  64,   0,  16,  64,
  32,  32,  64,  40,  32,  64,  48,  32,  64,  56,  32,  64,  64,  32,  64,  64,  32,  56,  64,  32,  48,  64,  32,  40,
  64,  32,  32,  64,  40,  32,  64,  48,  32,  64,  56,  32,  64,  64,  32,  56,  64,  32,  48,  64,  32,  40,  64,  32,
  32,  64,  32,  32,  64,  40,  32,  64,  48,  32,  64,  56,  32,  64,  64,  32,  56,  64,  32,  48,  64,  32,  40,  64,
  44,  44,  64,  48,  44,  64,  52,  44,  64,  60,  44,  64,  64,  44,  64,  64,  44,  60,  64,  44,  52,  64,  44,  48,
  64,  44,  44,  64,  48,  44,  64,  52,  44,  64,  60,  44,  64,  64,  44,  60,  64,  44,  52,  64,  44,  48,  64,  44,
  44,  64,  44,  44,  64,  48,  44,  64,  52,  44,  64,  60,  44,  64,  64,  44,  60,  64,  44,  52,  64,  44,  48,  64,
   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0
};

const PALETTE fb_palette_16  = {  16, palette_16_data  };
const PALETTE fb_palette_64  = {  64, palette_64_data  };
const PALETTE fb_palette_256 = { 256, palette_256_data };


static const unsigned char cga_association[5][4] = {
 {  0, 11, 13, 15 }, {  0, 10, 12, 14 }, {  0,  3,  5,  7 }, {  0,  2,  4,  6 }, {  0, 15 }
};
static const unsigned char ega_association[2][16] = {
 {  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15 },
 {  0,  1,  2,  3,  4,  5, 20,  7, 56, 57, 58, 59, 60, 61, 62, 63 }
};


/*:::::*/
unsigned int fb_hMakeColor(int index, int r, int g, int b)
{
	unsigned int color;

	if (fb_mode->bpp == 2)
		color = (b >> 3) | ((g << 3) & 0x07E0) | ((r << 8) & 0xF800);
	else
		color = index;

	return color;
}


/*:::::*/
unsigned int fb_hFixColor(unsigned int color)
{
	return fb_hMakeColor(color, (color >> 16) & 0xFF, (color >> 8) & 0xFF, color & 0xFF) & fb_mode->color_mask;
}


/*:::::*/
void fb_hRestorePalette(void)
{
	int i;
	
	for (i = 0; i < 256; i++) {
		fb_mode->driver->set_palette(i, (fb_mode->device_palette[i] & 0xFF),
						(fb_mode->device_palette[i] >> 8) & 0xFF,
						(fb_mode->device_palette[i] >> 16) & 0xFF);
	}
}


/*:::::*/
static void set_color(int index, unsigned int color)
{
	int r, g, b;

	if (fb_mode->default_palette == &fb_palette_256) {
		r = ((color & 0x3F) * 255.0) / 63.0;
		g = (((color & 0x3F00) >> 8) * 255.0) / 63.0;
		b = (((color & 0x3F0000) >> 16) * 255.0) / 63.0;
	}
	else {
		color &= (fb_mode->default_palette->colors - 1);
		r = (fb_mode->palette[color] & 0xFF);
		g = (fb_mode->palette[color] >> 8) & 0xFF;
		b = (fb_mode->palette[color] >> 16) & 0xFF;
		fb_mode->color_association[index] = color;
	}
	fb_mode->device_palette[index] = r | (g << 8) | (b << 16);
	fb_mode->driver->set_palette(index, r, g, b);
}


/*:::::*/
FBCALL void fb_GfxPalette(int index, unsigned int color)
{
	int i, r, g, b;
	const PALETTE *palette;
	const unsigned char *mode_association;
	
	if ((!fb_mode) || (fb_mode->depth > 8))
		return;

	fb_mode->driver->lock();
	
	if (index < 0) {
		palette = fb_mode->default_palette;
		switch (fb_mode->mode_num) {
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
			fb_mode->palette[i] = r | (g << 8) | (b << 16);
			if (i < (1 << fb_mode->depth)) {
				if (mode_association) {
					fb_mode->color_association[i] = mode_association[i];
					r = palette->data[fb_mode->color_association[i] * 3];
					g = palette->data[(fb_mode->color_association[i] * 3) + 1];
					b = palette->data[(fb_mode->color_association[i] * 3) + 2];
				}
				fb_mode->device_palette[i] = r | (g << 8) | (b << 16);
				fb_mode->driver->set_palette(i, r, g, b);
			}
		}
	}
	else
		set_color(index, color);
	
	fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
	
	fb_mode->driver->unlock();
}


/*:::::*/
FBCALL void fb_GfxPaletteUsing(int *data)
{
	int i;

	if ((!fb_mode) || (fb_mode->depth > 8))
		return;

	fb_mode->driver->lock();

	for (i = 0; i < (1 << fb_mode->depth); i++) {
		if (data[i] >= 0)
			set_color(i, data[i]);
	}

	fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);

	fb_mode->driver->unlock();
}
