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
FBCALL void fb_GfxScreenInfo(int *width, int *height, int *depth, int *bpp, int *pitch, FBSTRING *driver)
{
	if (!fb_mode) {
		fb_hStrRealloc(driver, 0, FB_FALSE);
		driver->data[0] = '\0';
		*bpp = *pitch = 0;
		fb_hScreenInfo(width, height, depth);
	}
	else {
		fb_hStrRealloc(driver, strlen(fb_mode->driver->name), FB_FALSE);
		strcpy(driver->data, fb_mode->driver->name);
		*width = fb_mode->w;
		*height = fb_mode->h;
		*depth = fb_mode->depth;
		*bpp = fb_mode->bpp;
		*pitch = fb_mode->pitch;
	}
}
