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
	FB_GFXCTX *context = fb_hGetContext();

	if (!__fb_gfx)
		return 0.0;
	
	fb_hPrepareTarget(context, NULL);
	fb_hSetPixelTransfer(context, MASK_A_32);
	
	switch (func) {
		
		case 0:
			if (context->flags & CTX_WINDOW_ACTIVE)
				coord = ((coord - context->win_x) * context->view_w) / (context->win_w - 1);
			return coord;
		
		case 1:
			if (context->flags & CTX_WINDOW_ACTIVE) {
				coord = ((coord - context->win_y) * context->view_h) / (context->win_h - 1);
				if ((context->flags & CTX_WINDOW_SCREEN) == 0)
					coord = context->view_h - 1 - coord;
			}
			return coord;
		
		case 2:
			if (context->flags & CTX_WINDOW_ACTIVE)
				coord = ((coord * (context->win_w - 1)) / context->view_w) + context->win_x;
			return coord;
		
		case 3:
			if (context->flags & CTX_WINDOW_ACTIVE) {
				if ((context->flags & CTX_WINDOW_SCREEN) == 0)
					coord = context->view_h - 1 - coord;
				coord = ((coord * (context->win_h - 1)) / context->view_h) + context->win_y;
			}
			return coord;
	}
	return 0;
}


/*:::::*/
FBCALL float fb_GfxCursor(int func)
{
	FB_GFXCTX *context = fb_hGetContext();
	
	if (!__fb_gfx)
		return 0.0;
	
	switch (func) {
		
		case 0: return fb_GfxPMap(context->last_x, 0);
		case 1: return fb_GfxPMap(context->last_y, 1);
		case 2: return context->last_x;
		case 3: return context->last_y;
	}
	return 0;
}
