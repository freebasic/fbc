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
 * pset.c -- pixel plotting
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxPset(float fx, float fy, int color, int coord_type)
{
	int x, y;
	
	if (!fb_mode)
		return;
	
	if (color == DEFAULT_COLOR)
		color = fb_mode->fg_color;
	else
		color = fb_hFixColor(color);
	
	fb_hFixRelative(coord_type, &fx, &fy, NULL, NULL);
	
	fb_hTranslateCoord(fx, fy, &x, &y);
	
	if ((x < fb_mode->view_x) || (y < fb_mode->view_y) ||
	    (x >= fb_mode->view_x + fb_mode->view_w) || (y >= fb_mode->view_y + fb_mode->view_h))
		return;
	
	DRIVER_LOCK();
	fb_hPutPixel(x, y, color);
	if (fb_mode->framebuffer == fb_mode->line[0])
		fb_mode->dirty[y] = TRUE;
	DRIVER_UNLOCK();
}
