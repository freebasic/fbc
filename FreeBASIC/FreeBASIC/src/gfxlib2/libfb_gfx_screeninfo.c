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


/*:::::*/
FBCALL void fb_GfxScreenInfo(int *width, int *height, int *depth, int *bpp, int *pitch, int *refresh, FBSTRING *driver)
{
	char *name;
	
	if (!__fb_gfx) {
		name = "";
		fb_hScreenInfo(width, height, depth, refresh);
		*bpp = *pitch = 0;
	}
	else {
		name = __fb_gfx->driver->name;
		*width = __fb_gfx->w;
		*height = __fb_gfx->h;
		*depth = __fb_gfx->depth;
		*bpp = __fb_gfx->bpp;
		*pitch = __fb_gfx->pitch;
		*refresh = __fb_gfx->refresh_rate;
	}
	
	if (fb_hStrDelTemp(driver)) {
		fb_hStrRealloc(driver, strlen(name), FB_FALSE);
		strcpy(driver->data, name);
	}
}
