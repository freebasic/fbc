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
FBCALL int fb_GfxIn(unsigned short port)
{
	int value = -1;

	if (!fb_mode)
		return -1;

	switch (port) {

		case 0x3C9:
			if (fb_mode->depth > 8)
				break;
			value = (fb_mode->device_palette[idx] >> shift) & 0x3F;
			shift += 8;
			if (shift > 18) {
				shift = 2;
				idx++;
				idx &= (fb_mode->default_palette->colors - 1);
			}
			break;
		
		case 0x3DA:
			fb_mode->driver->wait_vsync();
			value = 8;
			break;
	}

	return value;
}


/*:::::*/
FBCALL int fb_GfxOut(unsigned short port, unsigned char value)
{
	int i, r, g, b;

	if ((!fb_mode) || (fb_mode->depth > 8))
		return -1;

	switch (port) {

		case 0x3C7:
		case 0x3C8:
			idx = value & (fb_mode->default_palette->colors - 1);
			shift = 2;
			color = 0;
			break;

		case 0x3C9:
			color |= ((value & 0x3F) << shift);
			shift += 8;
			if (shift > 18) {
				if (fb_mode->default_palette == &fb_palette_256)
					fb_GfxPalette(idx, (color >> 2) & 0x3F3F3F, -1, -1);
				else {
					DRIVER_LOCK();
					r = color & 0xFF;
					g = (color >> 8) & 0xFF;
					b = (color >> 16) & 0xFF;
					fb_mode->palette[idx] = color;
					for (i = 0; i < (1 << fb_mode->depth); i++) {
						if (fb_mode->color_association[i] == idx) {
							fb_mode->device_palette[i] = color;
							fb_mode->driver->set_palette(i, r, g, b);
						}
					}
					fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
					DRIVER_UNLOCK();
				}
				shift = 2;
				color = 0;
				idx++;
				idx &= (fb_mode->default_palette->colors - 1);
			}
			break;
		
		default:
			return -1;
	}

	return 0;
}
