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
 * cls.c -- screen clearing routine
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
void fb_GfxClear(int mode)
{
	unsigned char *dest;
	unsigned char *dirty;
	int i, dirty_len;
	
	fb_mode->driver->lock();
	
	switch (mode) {
		
		case 0:
			/* Clear graphics viewport if set */
			dest = fb_mode->line[fb_mode->view_y] + (fb_mode->view_x * fb_mode->bpp);
			for (i = 0; i < fb_mode->view_h; i++) {
				fb_hPixelSet(dest, fb_mode->bg_color, fb_mode->view_w);
				dest += fb_mode->pitch;
			}
			dirty = fb_mode->dirty + fb_mode->view_y;
			dirty_len = fb_mode->view_h;
			break;
		
		case 2:
			/* Clear text viewport if set */
		
		case 1:
		default:
			/* Clear entire screen */
			fb_hPixelSet(fb_mode->line[0], fb_mode->bg_color, fb_mode->w * fb_mode->h);
			dirty = fb_mode->dirty;
			dirty_len = fb_mode->h;
			break;
	}
	fb_hMemSet(dirty, TRUE, dirty_len);
	
	fb_mode->driver->unlock();
	
	fb_mode->cursor_x = 0;
	fb_mode->cursor_y = 0;
	fb_mode->last_x = fb_mode->w >> 1;
	fb_mode->last_y = fb_mode->h >> 1;
}
