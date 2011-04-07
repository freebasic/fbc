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
 * color.c -- color statement
 *
 * chng: jan/2005 written [lillo]
 *
 */

#include "fb_gfx.h"


/*:::::*/
int fb_GfxColor(int fg, int bg, int flags)
{
	FB_GFXCTX *context = fb_hGetContext();
	int cur;
	if (__fb_gfx->depth <= 8) {
		cur = context->fg_color | (context->bg_color << 16);
	} else if (__fb_gfx->depth == 16) {
		unsigned c = context->fg_color;
		cur = (((c & 0x001F) << 3) | ((c >> 2) & 0x7) |
		       ((c & 0x07E0) << 5) | ((c >> 1) & 0x300) |
		       ((c & 0xF800) << 8) | ((c << 3) & 0x70000) | 0xff000000);
	} else {
		cur = context->fg_color;
	}
	
	switch (__fb_gfx->mode_num) {
	
		case 1:
			if (!(flags & FB_COLOR_BG_DEFAULT))
				fb_GfxPalette(-(4 - (bg & 0x3)), 0, 0, 0);
			if (!(flags & FB_COLOR_FG_DEFAULT))
				fb_GfxPalette(0, fg, -1, -1);
			break;
		
		case 7:
		case 8:
		case 9:
			if (!(flags & FB_COLOR_FG_DEFAULT))
				context->fg_color = (fg & 0xF);
			if (!(flags & FB_COLOR_BG_DEFAULT))
				fb_GfxPalette(0, bg, -1, -1);
			break;
		
		default:
			if (!(flags & FB_COLOR_FG_DEFAULT)) {
				if (__fb_gfx->depth > 8)
					context->fg_color = fb_hMakeColor(__fb_gfx->bpp, fg, (fg >> 16) & 0xFF, (fg >> 8) & 0xFF, fg & 0xFF);
				else
					context->fg_color = (fg & BPP_MASK(context->target_bpp));
			}
			if (!(flags & FB_COLOR_BG_DEFAULT)) {
				if (__fb_gfx->depth > 8)
					context->bg_color = fb_hMakeColor(__fb_gfx->bpp, bg, (bg >> 16) & 0xFF, (bg >> 8) & 0xFF, bg & 0xFF);
				else
					context->bg_color = (bg & BPP_MASK(context->target_bpp));
			}
			break;
	}

	return cur;
}
