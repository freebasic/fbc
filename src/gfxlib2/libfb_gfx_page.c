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
FBCALL int fb_GfxFlip(int from_page, int to_page)
{
	FB_GFXCTX *context = fb_hGetContext();
	unsigned char *dest, *src;
	int i, size, text_size, lock = FALSE;
	int src_page, dest_page;

	if (!__fb_gfx)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);

	if (__fb_gfx->driver->flip) {
		__fb_gfx->driver->flip();
		if (__fb_gfx->driver->poll_events)
			__fb_gfx->driver->poll_events();
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	}

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

	if (from_page < 0) {
		src = context->line[0];
		src_page = context->work_page;
	}
	else if (from_page >= __fb_gfx->num_pages)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	else {
		src = __fb_gfx->page[from_page];
		src_page = from_page;
	}
	if (to_page < 0) {
		dest = __fb_gfx->framebuffer;
		dest_page = __fb_gfx->visible_page;
	}
	else if (to_page >= __fb_gfx->num_pages)
		return fb_ErrorSetNum(FB_RTERROR_ILLEGALFUNCTIONCALL);
	else {
		dest = __fb_gfx->page[to_page];
		dest_page = to_page;
	}

	if (src == dest)
		return fb_ErrorSetNum(FB_RTERROR_OK);
	if ((dest == __fb_gfx->framebuffer) && (__fb_gfx->lock_count==0))
		lock = TRUE;

	text_size = __fb_gfx->text_w * __fb_gfx->text_h * sizeof(GFX_CHAR_CELL);

	src += (context->view_y * __fb_gfx->pitch) + (context->view_x * __fb_gfx->bpp);
	dest += (context->view_y * __fb_gfx->pitch) + (context->view_x * __fb_gfx->bpp);
	size = context->view_w * __fb_gfx->bpp;

	if (lock)
		DRIVER_LOCK();
	for (i = context->view_h; i; i--) {
		fb_hMemCpy(dest, src, size);
		dest += __fb_gfx->pitch;
		src += __fb_gfx->pitch;
	}
	/* Copy the character cell pages too */
	fb_hMemCpy(__fb_gfx->con_pages[dest_page], __fb_gfx->con_pages[src_page], text_size);
	if (lock) {
		fb_hMemSet(__fb_gfx->dirty + context->view_y, TRUE, context->view_h);
		DRIVER_UNLOCK();
	}

	return fb_ErrorSetNum(FB_RTERROR_OK);
}

/*:::::*/
int fb_GfxPageCopy(int from_page, int to_page)
{
	return fb_GfxFlip( from_page, to_page );
}

/*:::::*/
int fb_GfxPageSet(int work_page, int visible_page)
{
	FB_GFXCTX *context = fb_hGetContext();

	int res = context->work_page | (__fb_gfx->visible_page << 8);

	if (!__fb_gfx)
		return -1;

	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);

	if ((work_page < 0) && (visible_page < 0))
		work_page = visible_page = 0;

	if ((work_page >= 0) && (work_page < __fb_gfx->num_pages)) {
		int i;
		for (i = 0; i < __fb_gfx->h; i++)
			context->line[i] = __fb_gfx->page[work_page] + (i * __fb_gfx->pitch);
		context->work_page = work_page;
	}
	if ((visible_page >= 0) && (visible_page < __fb_gfx->num_pages) && (visible_page != __fb_gfx->visible_page)) {
		DRIVER_LOCK();
		__fb_gfx->framebuffer = __fb_gfx->page[visible_page];
		__fb_gfx->visible_page = visible_page;
		fb_hMemSet(__fb_gfx->dirty, TRUE, __fb_gfx->h);
		DRIVER_UNLOCK();
	}

	return res;
}


