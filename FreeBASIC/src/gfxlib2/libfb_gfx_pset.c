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
FBCALL void fb_GfxPset(void *target, float fx, float fy, unsigned int color, int flags, int ispreset)
{
	FB_GFXCTX *context = fb_hGetContext();
	int x, y;
	
	if (!__fb_gfx)
		return;

	fb_hPrepareTarget(context, target);
	
	if (flags & DEFAULT_COLOR_1) {
		if (ispreset)
			color = context->bg_color;
		else
			color = context->fg_color;
	}
	else
		color = fb_hFixColor(context->target_bpp, color);
	
	fb_hSetPixelTransfer(context, color);
	
	fb_hFixRelative(context, flags, &fx, &fy, NULL, NULL);
	
	fb_hTranslateCoord(context, fx, fy, &x, &y);
	
	if ((x < context->view_x) || (y < context->view_y) ||
	    (x >= context->view_x + context->view_w) || (y >= context->view_y + context->view_h))
		return;
	
	DRIVER_LOCK();
	context->put_pixel(context, x, y, color);
	if (__fb_gfx->framebuffer == context->line[0])
		__fb_gfx->dirty[y] = TRUE;
	DRIVER_UNLOCK();
}
