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
 * vgaemu.c -- VGA in/out emulation
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


static int idx = 0, shift = 2, color = 0;


/*:::::*/
FBCALL int fb_GfxPaletteInp(int port)
{
	int value = 0;

	if ((!fb_mode) || (fb_mode->depth > 8))
		return;

	switch (port) {

		case 0x3C9:
			value = (fb_mode->palette[idx] >> shift) & 0x3F;
			shift += 8;
			if (shift > 18) {
				shift = 2;
				idx++;
				idx &= (fb_mode->default_palette->colors - 1);
			}
			break;
	}

	return value;
}


/*:::::*/
FBCALL void fb_GfxPaletteOut(int port, int value)
{
	int i, r, g, b;

	if ((!fb_mode) || (fb_mode->depth > 8))
		return;

	value &= 0xFF;

	switch (port) {

		case 0x3C7:
            idx = value;
            shift = 2;
            color = 0;
            break;

		case 0x3C8:
			idx = value;
			shift = 0;
			color = 0;
			break;

		case 0x3C9:
			color |= ((value & 0x3F) << shift);
			shift += 8;
			if (shift > 18) {
				if (fb_mode->default_palette == &fb_palette_256)
					fb_GfxPalette(idx, color);
				else {
					fb_mode->driver->lock();
					r = ((color & 0x3F) * 255.0) / 63.0;
					g = (((color & 0x3F00) >> 8) * 255.0) / 63.0;
					b = (((color & 0x3F0000) >> 16) * 255.0) / 63.0;
					fb_mode->palette[idx] = r | (g << 8) | (b << 16);
					for (i = 0; i < (1 << fb_mode->depth); i++) {
						if (fb_mode->color_association[i] == idx) {
							fb_mode->device_palette[i] = r | (g << 8) | (b << 16);
							fb_mode->driver->set_palette(i, r, g, b);
						}
					}
					fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
					fb_mode->driver->unlock();
				}
				shift = 0;
				color = 0;
				idx++;
				idx &= (fb_mode->default_palette->colors - 1);
			}
			break;
	}

}


FBCALL void fb_GfxWaitVSync(int port, int and_mask, int xor_mask)
{
	if ((port == 0x3DA) && (and_mask == 8) && (!xor_mask) && (fb_mode))
			fb_mode->driver->wait_vsync();
}
