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
 * screeninfo.c -- Function to get informations about current gfx mode.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

static GFXDRIVERINFO none = { { "none", 4 }, 0 };
static GFXDRIVERINFO info;


/*:::::*/
FBCALL GFXDRIVERINFO *fb_GfxScreenInfo(void)
{
	int len;
	
	if (!fb_mode)
		return &none;
	
	info.driver_name.data = fb_mode->driver->name;
	info.driver_name.len = strlen(fb_mode->driver->name);
	info.w = fb_mode->w;
	info.h = fb_mode->h;
	info.depth = fb_mode->depth;
	info.pitch = fb_mode->pitch;
	info.bpp = fb_mode->bpp;
	info.mask_color = fb_mode->color_mask;
	info.num_pages = fb_mode->num_pages;
	info.flags = fb_mode->flags;
	
	return &info;
}
