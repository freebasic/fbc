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
 * box.c -- internal box drawing routine. Used both by VIEW and LINE.
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"

/* Assumes x1,y1 to be upper left corner and x2,y2 lower right one.
 * Assumes coordinates to be physical ones.
 * Also assumes color is already masked. */

/*:::::*/
void fb_hGfxBox(int x1, int y1, int x2, int y2, unsigned int color, int full, unsigned int style)
{
	FB_GFXCTX *context = fb_hGetContext();
	unsigned char *dest, rot;
	int clipped_x1, clipped_y1, clipped_x2, clipped_y2, w, h, bit;
	
	if ((x2 < context->view_x) || (y2 < context->view_y) ||
	    (x1 >= context->view_x + context->view_w) || (y1 >= context->view_y + context->view_h))
		return;

	clipped_x1 = MAX(x1, context->view_x);
	clipped_y1 = MAX(y1, context->view_y);
	clipped_x2 = MIN(x2, context->view_x + context->view_w - 1);
	clipped_y2 = MIN(y2, context->view_y + context->view_h - 1);
	
	DRIVER_LOCK();
	
	if (full) {
		w = clipped_x2 - clipped_x1 + 1;
		h = clipped_y2 - clipped_y1 + 1;
		dest = context->line[clipped_y1] + (clipped_x1 * context->target_bpp);
		for (; h; h--) {
			context->pixel_set(dest, color, w);
			dest += context->target_pitch;
		}
	}
	else {
		bit = 0x8000;
		if (style != 0xFFFF) {
			rot = (clipped_x1 - x1) & 0xF;
			RORW(bit, rot);
		}
		if (y2 < context->view_y + context->view_h) {
			if (style == 0xFFFF)
				context->pixel_set(context->line[y2] + (clipped_x1 * context->target_bpp), color, clipped_x2 - clipped_x1 + 1);
			else {
				for (w = clipped_x1; w <= clipped_x2; w++) {
					if (style & bit)
						context->put_pixel(context, w, y2, color);
					RORW1(bit);
				}
			}
		}
		else if (style != 0xFFFF) {
			rot = (clipped_x2 - clipped_x1 + 1) & 0xF;
			RORW(bit, rot);
		}
		if (style != 0xFFFF) {
			rot = ((x2 - clipped_x2) + (clipped_x1 - x1)) & 0xF;
			RORW(bit, rot);
		}
		
		if (y1 >= context->view_y) {
			if (style == 0xFFFF)
				context->pixel_set(context->line[y1] + (clipped_x1 * context->target_bpp), color, clipped_x2 - clipped_x1 + 1);
			else {
				for (w = clipped_x1; w <= clipped_x2; w++) {
					if (style & bit)
						context->put_pixel(context, w, y1, color);
					RORW1(bit);
				}
			}
		}
		else if (style != 0xFFFF) {
			rot = (clipped_x2 - clipped_x1 + 1) & 0xF;
			RORW(bit, rot);
		}
		if (style != 0xFFFF) {
			rot = ((x2 - clipped_x2) + (clipped_y1 - y1)) & 0xF;
			RORW(bit, rot);
		}
		if (x2 < context->view_x + context->view_w) {
			for (h = clipped_y1; h <= clipped_y2; h++) {
				if (style & bit)
					context->put_pixel(context, x2, h, color);
				RORW1(bit);
			}
		}
		else if (style != 0xFFFF) {
			rot = (clipped_y2 - clipped_y1 + 1) & 0xF;
			RORW(bit, rot);
		}
		if (style != 0xFFFF) {
			rot = ((y2 - clipped_y2) + (clipped_y1 - y1)) & 0xF;
			RORW(bit, rot);
		}
		if (x1 >= context->view_x) {
			for (h = clipped_y1; h <= clipped_y2; h++) {
				if (style & bit)
					context->put_pixel(context, x1, h, color);
				RORW1(bit);
			}
		}
	}
	
	SET_DIRTY(context, clipped_y1, clipped_y2 - clipped_y1 + 1);
	
	DRIVER_UNLOCK();
}
