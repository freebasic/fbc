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
 * page.c -- screen multiple pages handling
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
FBCALL void fb_GfxFlip(int from_page, int to_page)
{
	unsigned char *dest, *src;
	
	if (!fb_mode)
		return;
	
	if (from_page < 0)
		src = fb_mode->line[0];
	else if (from_page >= fb_mode->num_pages)
		return;
	else
		src = fb_mode->page[from_page];
	if (to_page < 0)
		dest = fb_mode->framebuffer;
	else if (to_page >= fb_mode->num_pages)
		return;
	else
		dest = fb_mode->page[to_page];
		
	if (dest == fb_mode->framebuffer)
		fb_mode->driver->lock();
	fb_hMemCpy(dest, src, fb_mode->pitch * fb_mode->h);
	if (dest == fb_mode->framebuffer) {
		fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
		fb_mode->driver->unlock();
	}
}


/*:::::*/
FBCALL void fb_GfxSetPage(int work_page, int visible_page)
{
	int i;
	
	if (!fb_mode)
		return;
	
	if ((work_page < 0) && (visible_page < 0))
		work_page = visible_page = 0;
	
	if ((work_page >= 0) && (work_page < fb_mode->num_pages)) {
		for (i = 0; i < fb_mode->h; i++)
			fb_mode->line[i] = fb_mode->page[work_page] + (i * fb_mode->pitch);
	}
	if ((visible_page >= 0) && (visible_page < fb_mode->num_pages) && (fb_mode->page[visible_page] != fb_mode->framebuffer)) {
		fb_mode->driver->lock();
		fb_mode->framebuffer = fb_mode->page[visible_page];
		fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
		fb_mode->driver->unlock();
	}
}
