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
 * color.c -- color statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
void fb_GfxColor(int fg, int bg)
{
	const unsigned char *palette;
	int i;
	
	if (fb_mode->depth == 2) {
		if ((fg >= 0) || (bg >= 0)) {
			fb_mode->driver->lock();
			if (fg >= 0) {
				palette = fb_vga_palette[fg & 0xF];
				fb_mode->palette[0] = fb_hMakeColor(0, palette[0], palette[1], palette[2]);
				fb_mode->driver->set_palette(0, palette[0], palette[1], palette[2]);
			}
			if (bg >= 0) {
				palette = fb_cga_palette[4 + ((bg & 0x1) * 3)];
				for (i = 1; i < 4; i++) {
					fb_mode->palette[i] = fb_hMakeColor(i, palette[0], palette[1], palette[2]);
					fb_mode->driver->set_palette(i, palette[0], palette[1], palette[2]);
					palette += 3;
				}
			}
			fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
			fb_mode->driver->unlock();
		}
	}
	else {
		if (fg >= 0) {
			if (fb_mode->depth > 8)
				fb_mode->fg_color = fb_hMakeColor(fg, (fg >> 16) & 0xFF, (fg >> 8) & 0xFF, fg & 0xFF);
			else
				fb_mode->fg_color = (fg & fb_mode->color_mask);
		}
		if (bg >= 0) {
			if (fb_mode->depth > 8)
				fb_mode->bg_color = fb_hMakeColor(bg, (bg >> 16) & 0xFF, (bg >> 8) & 0xFF, bg & 0xFF);
			else
				fb_mode->bg_color = (bg & fb_mode->color_mask);
		}
	}
}
