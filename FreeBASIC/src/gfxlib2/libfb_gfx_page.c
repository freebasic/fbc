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
    int i, size, lock = FALSE;
    int src_page, dst_page;
	
	if (!fb_mode)
        return;

    src_page = ((from_page<0) ? fb_mode->work_page : from_page);
    dst_page = ((  to_page<0) ? fb_mode->work_page :   to_page);

    if( src_page!=dst_page) {
        /* Copy the character cell pages too */
        size_t text_size = fb_mode->text_w * fb_mode->text_h;
        DRIVER_LOCK();
        fb_hMemCpy( fb_mode->con_pages[dst_page],
                    fb_mode->con_pages[src_page],
                    text_size * sizeof(GFX_CHAR_CELL) );
        DRIVER_UNLOCK();
    }
	
	if (fb_mode->driver->flip) {
		fb_mode->driver->flip();
		return;
	}
	
	fb_hPrepareTarget(NULL);

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
	
	if (src == dest)
		return;
	if ((dest == fb_mode->framebuffer) && (!(fb_mode->flags & SCREEN_LOCKED)))
		lock = TRUE;
	
	src += (fb_mode->view_y * fb_mode->pitch) + (fb_mode->view_x * fb_mode->bpp);
	dest += (fb_mode->view_y * fb_mode->pitch) + (fb_mode->view_x * fb_mode->bpp);
	size = fb_mode->view_w * fb_mode->bpp;
	
	if (lock)
		DRIVER_LOCK();
	for (i = fb_mode->view_h; i; i--) {
		fb_hMemCpy(dest, src, size);
		dest += fb_mode->pitch;
		src += fb_mode->pitch;
	}
	if (lock) {
		fb_hMemSet(fb_mode->dirty + fb_mode->view_y, TRUE, fb_mode->view_h);
		DRIVER_UNLOCK();
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
		fb_mode->work_page = work_page;
	}
	if ((visible_page >= 0) && (visible_page < fb_mode->num_pages) && (fb_mode->page[visible_page] != fb_mode->framebuffer)) {
		DRIVER_LOCK();
		fb_mode->framebuffer = fb_mode->page[visible_page];
		fb_hMemSet(fb_mode->dirty, TRUE, fb_mode->h);
		DRIVER_UNLOCK();
	}
}
