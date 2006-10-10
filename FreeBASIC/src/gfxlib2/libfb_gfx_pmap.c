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
 * pmap.c -- pmap statement and point function with one argument
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL float fb_GfxPMap(float coord, int func)
{
	if (!fb_mode)
		return 0.0;
	
	fb_hPrepareTarget(NULL, MASK_A_32);
	
	switch (func) {
		
		case 0:
			if (fb_mode->flags & WINDOW_ACTIVE)
				coord = ((coord - fb_mode->win_x) * fb_mode->view_w) / (fb_mode->win_w - 1);
			return coord;
		
		case 1:
			if (fb_mode->flags & WINDOW_ACTIVE) {
				coord = ((coord - fb_mode->win_y) * fb_mode->view_h) / (fb_mode->win_h - 1);
				if ((fb_mode->flags & WINDOW_SCREEN) == 0)
					coord = fb_mode->view_h - 1 - coord;
			}
			return coord;
		
		case 2:
			if (fb_mode->flags & WINDOW_ACTIVE)
				coord = ((coord * (fb_mode->win_w - 1)) / fb_mode->view_w) + fb_mode->win_x;
			return coord;
		
		case 3:
			if (fb_mode->flags & WINDOW_ACTIVE) {
				if ((fb_mode->flags & WINDOW_SCREEN) == 0)
					coord = fb_mode->view_h - 1 - coord;
				coord = ((coord * (fb_mode->win_h - 1)) / fb_mode->view_h) + fb_mode->win_y;
			}
			return coord;
	}
	return 0;
}


/*:::::*/
FBCALL float fb_GfxCursor(int func)
{
	if (!fb_mode)
		return 0.0;
	
	switch (func) {
		
		case 0: return fb_GfxPMap(fb_mode->last_x, 0);
		case 1: return fb_GfxPMap(fb_mode->last_y, 1);
		case 2: return fb_mode->last_x;
		case 3: return fb_mode->last_y;
	}
	return 0;
}
