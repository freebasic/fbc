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
 * window.c -- WINDOW statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxWindow(float x1, float y1, float x2, float y2, int screen)
{
	int temp;
	
	if (!fb_mode)
		return;
	
	if (x1 || y1 || x2 || y2) {
		if (x2 < x1) {
			temp = x1;
			x1 = x2;
			x2 = temp;
		}
		if (y2 < y1) {
			temp = y1;
			y1 = y2;
			y2 = temp;
		}
		
		fb_mode->win_x = x1;
		fb_mode->win_w = x2 - x1 + 1;
		fb_mode->win_y = y1;
		fb_mode->win_h = y2 - y1 + 1;
		fb_mode->flags |= WINDOW_ACTIVE;
		if (screen)
			fb_mode->flags |= WINDOW_SCREEN;
	}
	else
		fb_mode->flags &= ~(WINDOW_ACTIVE | WINDOW_SCREEN);
}
